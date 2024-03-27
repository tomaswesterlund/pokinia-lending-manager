class Response {
  final bool success;
  final String message;

  bool get succeeded => success;

  Response({required this.success, required this.message});

  Response.success()
      : success = true,
        message = '';
  Response.successWithMessage({required this.message}) : success = true;

  Response.error()
      : success = false,
        message = '';

  Response.errorWithMessage({required this.message}) : success = false;
}
