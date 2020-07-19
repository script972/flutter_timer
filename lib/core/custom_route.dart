import 'package:flutter/material.dart';
import 'package:flutter_app/ui/screen/timer_screen.dart';
import 'package:flutter_app/ui/screen/setup_screen.dart';

class CustomRoute {
  static const String TIMER_SCREEN = '/TIMER';
  static const String SETUP_SCREEN = '/SETUP';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget screen = SetupScreen();
    final args = settings.arguments;
    switch (settings.name) {
      case SETUP_SCREEN:
        screen = SetupScreen();
        break;
      case TIMER_SCREEN:
        screen = TimerScreen();
        break;
    }
    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
