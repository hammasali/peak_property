import 'package:flutter/material.dart';
import 'package:peak_property/auth/login/login_screen.dart';
import 'package:peak_property/auth/register/register_screen.dart';
import 'package:peak_property/auth/signIn/signin_screen.dart';
import 'package:peak_property/presentation/app_navigation.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String signIn = 'login/signIn';
  static const String appNavigation = '/appNavigation';
}

class RouteNavigator extends StatelessWidget {
  const RouteNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState!.canPop();
        if (canPop) {
          navigatorKey.currentState!.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: Routes.loginRoot,
        onGenerateRoute: (RouteSettings settings) {
          late WidgetBuilder builder;
          switch (settings.name) {
            case Routes.loginRoot:
              builder = (BuildContext _) => const LoginScreen();
              break;

            case Routes.registration:
              builder = (BuildContext _) => const RegisterScreen();
              break;

            case Routes.signIn:
              builder = (BuildContext _) => const SignInScreen();
              break;

            case Routes.appNavigation:
              builder = (BuildContext _) => const AppNavigation();
              break;
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}
