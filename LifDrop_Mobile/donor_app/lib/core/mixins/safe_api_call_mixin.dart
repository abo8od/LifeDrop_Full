import 'package:donor_app/core/networking/api_error_handler.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

mixin SafeApiCallMixin {
  /// Wraps every API call with unified error handling and Crashlytics logging.
  Future<ApiResult<T>> safeApiCall<T>(
    String endpoint,
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return ApiResult.success(result);
    } catch (e, stack) {
      final error = ApiErrorHandler.handle(e);

      FirebaseCrashlytics.instance.log("""
      $endpoint API ERROR:
      Endpoint: '$endpoint'
      Status: ${error.code}
      Errors: ${error.getAllErrorMessages()}
      """);

      FirebaseCrashlytics.instance.recordError(e, stack);

      return ApiResult.failure(error);
    }
  }
}
