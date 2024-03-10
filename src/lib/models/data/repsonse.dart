class Response {
  final int statusCode;
  final String message;
  dynamic data;

  bool get succeeded => statusCode == 200;

  Response({required this.statusCode, this.message = '', this.data});

  Response.success()
      : statusCode = 200,
        message = '',
        data = null;

  Response.error(this.message) : statusCode = 500;
}
