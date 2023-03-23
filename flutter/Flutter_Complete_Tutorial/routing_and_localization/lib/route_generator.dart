import 'package:flutter/material.dart';
import 'package:routing_and_localization/error_screen.dart';
import 'package:routing_and_localization/first_screen.dart';
import 'package:routing_and_localization/second_screen.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case '/first':
        return MaterialPageRoute(builder: (_) => const FirstScreen());
      case '/second':
        final _arg = (settings.arguments ?? {}) as Map<String,dynamic>;
        return MaterialPageRoute(builder: (_) => SecondScreen(
          name: _arg['name'] ?? {},
          age: _arg['age'] ?? {},
          roll: _arg['roll'] ?? {},
        ));
    }

    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
