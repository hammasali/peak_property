import 'package:flutter/material.dart';
import 'package:peak_property/auth_screens/login_screen.dart';
import 'package:peak_property/auth_screens/register_screen.dart';
import 'package:peak_property/auth_screens/signin_screen.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';

void main() {
  runApp(PeakProperty());
}

class PeakProperty extends StatelessWidget {
  PeakProperty({Key? key}) : super(key: key);
  final AppRoutes _appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.kAppTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _appRoutes.onGenerateRoute,
      home: const SignInScreen(),
    );
  }
}
