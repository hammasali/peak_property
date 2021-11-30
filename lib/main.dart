import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/presentation/home_screen.dart';
import 'package:peak_property/presentation/signin_screen.dart';

void main() {


  runApp(PeakProperty());

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.white,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  //   systemNavigationBarIconBrightness: Brightness.dark,
  //   systemNavigationBarContrastEnforced: true,
  //   systemStatusBarContrastEnforced: true,
  // ));
}

class PeakProperty extends StatelessWidget {
  PeakProperty({Key? key}) : super(key: key);
  final AppRoutes _appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: MyApp.kDefaultBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: _appRoutes.onGenerateRoute,
      home: const HomeScreen(),
    );
  }
}
