class ApiResult<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResult.success(T this.data)
      : success = true,
        error = null;

  ApiResult.error(String this.error)
      : success = false,
        data = null;
}
