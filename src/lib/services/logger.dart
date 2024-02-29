// var logger = Logger(
//   printer: PrettyPrinter(
//       methodCount: 2, // Number of method calls to be displayed
//       errorMethodCount: 8, // Number of method calls if stacktrace is provided
//       lineLength: 120, // Width of the output
//       colors: true, // Colorful log messages
//       printEmojis: true, // Print an emoji for each log message
//       printTime: false // Should each log print contain a timestamp
//       ),
// );

import 'package:logger/logger.dart';

Logger getLogger(String className) {
  var logger = Logger(
    printer: PrettyPrinter(
        methodCount: 0, // Number of method calls to be displayed
        errorMethodCount: 3, // Number of method calls if stacktrace is provided
        lineLength: 50, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  return logger;
}
