class Response {
  final int statusCode;
  final String? body;

  Response({required this.statusCode, this.body});

  Response.success()
      : statusCode = 200,
        body = null;

  Response.error(this.body) : statusCode = 500;
}
