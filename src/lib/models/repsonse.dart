class Response {
  final int statusCode;
  final String? body;

  bool get succeeded => statusCode == 200;

  Response({required this.statusCode, this.body});

  Response.success()
      : statusCode = 200,
        body = null;

  Response.error(this.body) : statusCode = 500;
}
