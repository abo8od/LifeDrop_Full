using System.Collections.Concurrent;
using System.Text.Json;
using Core.Entities;
using Infrastructure.Data;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Api.BackgroundWorkers;

public class ProcessOutboxMessagesWorker : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<ProcessOutboxMessagesWorker> _logger;

    // Cache Type lookups so reflection only runs once per distinct type name across the lifetime of the worker.
    private static readonly ConcurrentDictionary<string, Type?> _typeCache = new();

    private const int BatchSize = 20;
    private static readonly TimeSpan IdleDelay = TimeSpan.FromSeconds(5);

    public ProcessOutboxMessagesWorker(
        IServiceProvider serviceProvider,
        ILogger<ProcessOutboxMessagesWorker> logger)
    {
        _serviceProvider = serviceProvider;
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Outbox Background Worker started.");

        while (!stoppingToken.IsCancellationRequested)
        {
            int processed = 0;

            try
            {
                using var scope = _serviceProvider.CreateScope();
                var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
                var publisher = scope.ServiceProvider.GetRequiredService<IPublisher>();

                var messages = await dbContext.OutboxMessages
                    .Where(m => m.ProcessedOn == null)
                    .OrderBy(m => m.CreatedOn)
                    .Take(BatchSize)
                    .ToListAsync(stoppingToken);

                processed = messages.Count;

                if (processed > 0)
                {
                    foreach (var message in messages)
                    {
                        try
                        {
                            var type = _typeCache.GetOrAdd(message.Type, static t => Type.GetType(t));
                            if (type == null)
                            {
                                message.Error = $"Could not resolve type: {message.Type}";
                                message.ProcessedOn = DateTimeOffset.UtcNow;
                                continue;
                            }

                            var notification = JsonSerializer.Deserialize(message.Content, type) as INotification;
                            if (notification == null)
                            {
                                message.Error = $"Could not deserialize content to INotification: {message.Type}";
                                message.ProcessedOn = DateTimeOffset.UtcNow;
                                continue;
                            }

                            await publisher.Publish(notification, stoppingToken);
                            message.ProcessedOn = DateTimeOffset.UtcNow;
                        }
                        catch (Exception ex)
                        {
                            message.Error = ex.Message;
                            _logger.LogError(ex, "Error processing outbox message {MessageId}", message.Id);
                            message.ProcessedOn = DateTimeOffset.UtcNow;
                        }
                    }

                    await dbContext.SaveChangesAsync(stoppingToken);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error in ProcessOutboxMessagesWorker");
            }

            // If we got a full batch, there are likely more messages — loop immediately.
            // Only sleep when the batch was partial (or empty), meaning the queue is drained.
            if (processed < BatchSize)
                await Task.Delay(IdleDelay, stoppingToken);
        }
    }
}
