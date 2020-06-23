import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    printTime: true,
    colors: false,
  ),
);