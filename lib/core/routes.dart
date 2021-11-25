import 'package:flutter/material.dart';

class AppRoutes {
  Route? onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        default:
          return null;
      }
    } catch (e) {
      print(e);
    }
  }

   void dispose() {}
}
