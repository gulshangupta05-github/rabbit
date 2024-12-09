import 'package:flutter/material.dart';

class NavigationHelper {
  // Static method to create the page route with custom transition
  static Route<dynamic> createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  // Static method to navigate to any screen using the custom transition
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, createRoute(screen));
  }

  // Optional: Static method to replace the current screen with a new one
  static void replaceScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(context, createRoute(screen));
  }

  // Optional: Static method to pop the current screen
  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
