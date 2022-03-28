import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed( const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.kDefaultBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Logging Out...',
                style: Theme.of(context).textTheme.bodyText1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getCircularProgress(),
            ),
          ],
        ),
      ),
    );
  }
}
