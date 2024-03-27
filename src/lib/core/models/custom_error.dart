class CustomError {
  final String message;

  CustomError(Exception exception) : message = exception.toString();

  CustomError.withMessage(this.message);

  CustomError.withException(Exception exception)
      : message = exception.toString();
}
