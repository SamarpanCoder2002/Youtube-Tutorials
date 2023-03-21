import 'package:flutter/foundation.dart';

class Logging {
  // info, warning, error

  static info(dynamic textToPrint) {
    if (!kDebugMode) return;

    final stackTrace = StackTrace.current;
    final _sourceFileLink = stackTrace.toString().split("\n")[1];
    final _regexCodeLine = RegExp(r" (\(.*\))$");
    final _matchData = _regexCodeLine.stringMatch(_sourceFileLink);

    debugPrint(
        '\x1B[32m[${DateTime.now()}] $_matchData\n$textToPrint\x1B[0m\n\n');
  }

  static warning(dynamic textToPrint) {
    if (!kDebugMode) return;

    final stackTrace = StackTrace.current;
    final _sourceFileLink = stackTrace.toString().split("\n")[1];
    final _regexCodeLine = RegExp(r" (\(.*\))$");
    final _matchData = _regexCodeLine.stringMatch(_sourceFileLink);

    debugPrint(
        '\x1B[33m[${DateTime.now()}] $_matchData\n$textToPrint\x1B[0m\n\n');
  }

  static error(dynamic textToPrint) {
    if (!kDebugMode) return;

    final stackTrace = StackTrace.current;
    final _sourceFileLink = stackTrace.toString().split("\n")[1];
    final _regexCodeLine = RegExp(r" (\(.*\))$");
    final _matchData = _regexCodeLine.stringMatch(_sourceFileLink);

    debugPrint(
        '\x1B[31m[${DateTime.now()}] $_matchData\n$textToPrint\x1B[0m\n\n');
  }

  /**
   
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m

   */
}
