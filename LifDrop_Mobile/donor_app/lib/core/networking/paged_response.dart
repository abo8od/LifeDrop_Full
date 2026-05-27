import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class PagedResponse<T> {
  final List<T> data;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  PagedResponse({
    required this.data,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PagedResponseFromJson(json, fromJsonT);
}
