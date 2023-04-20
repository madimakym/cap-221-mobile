import 'package:cap221_app/features/auth/login/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(
            builder: (context) => const LoginPage(), fullscreenDialog: true);
      // case "/register":
      //   return MaterialPageRoute(builder: (context) => const RegisterPage());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}

class NavigatorArguments {
  final String title;
  final dynamic params;

  NavigatorArguments({required this.title, required this.params});
}
