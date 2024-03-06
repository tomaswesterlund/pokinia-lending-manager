class Response {
  final int statusCode;
  final String message;

  bool get succeeded => statusCode == 200;

  Response({required this.statusCode, this.message = ''});

  Response.success()
      : statusCode = 200,
        message = '';

  Response.error(this.message) : statusCode = 500;
}
