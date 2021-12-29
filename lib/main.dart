import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/theme.dart';

import 'core/routes.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const PeakProperty());
}

class PeakProperty extends StatelessWidget {
  const PeakProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const RouteNavigator(),
    );
  }
}
