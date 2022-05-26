class ApiResponse<T> {
  bool status;
  String message;
  T? data;

  ApiResponse({
    required this.status,
    this.message = '',
    this.data,
  });

  ApiResponse.success(this.data)
      : status = true,
        message = '';

  ApiResponse.error(this.message)
      : status = false,
        data = null;
}
