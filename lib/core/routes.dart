import 'package:camera_capture/camera_capture.dart';
import 'package:draw_page/draw_page.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/auth/login/login_screen.dart';
import 'package:peak_property/auth/register/register_screen.dart';
import 'package:peak_property/auth/signIn/signin_screen.dart';

import 'package:peak_property/presentation/app_navigation.dart';
import 'package:peak_property/presentation/chat/chat_screen.dart';
import 'package:peak_property/presentation/drawer/edit_profile/edit_profile.dart';
import 'package:peak_property/presentation/drawer/profile/profile.dart';
import 'package:peak_property/presentation/home/bid/bid_detail.dart';
import 'package:peak_property/presentation/home/bid/place_bid.dart';
import 'package:peak_property/presentation/home/fixed/fixed_detail.dart';
import 'package:peak_property/presentation/upload/upload.dart';
import 'package:peak_property/services/models/upload_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  static const String loginRoot = 'login/';
  static const String registration = 'login/registration';
  static const String signIn = 'login/signIn';
  static const String appNavigation = 'appNavigation';
  static const String fixedDetails = '/fixedDetails';
  static const String bidDetails = '/bidDetails';
  static const String conversationScreen = '/conversationScreen';
  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String upload = '/upload_bloc';
  static const String placeBid = '/placeBid';
  static const String cameraPage = '/cameraPage';
  static const String drawPage = '/drawPage';
}

class RouteNavigator extends StatelessWidget {
  final String initialRoute;

  const RouteNavigator({Key? key, required this.initialRoute})
      : super(key: key);

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
        initialRoute: initialRoute,
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

            case Routes.fixedDetails:
              builder = (BuildContext _) =>
                  FixedDetailScreen(model: settings.arguments as UploadModel);
              break;

            case Routes.bidDetails:
              builder = (BuildContext _) => const BidDetails();
              break;

            case Routes.placeBid:
              builder = (BuildContext _) => PlaceBidScreen();
              break;

            case Routes.conversationScreen:
              builder = (BuildContext _) => ChatSingleScreen();
              break;

            case Routes.profile:
              builder = (BuildContext _) => const Profile();
              break;

            case Routes.editProfile:
              builder = (BuildContext _) => const EditProfile();
              break;

            case Routes.upload:
              builder = (BuildContext _) => const Upload();
              break;

            // case Routes.cameraPage:
            //   builder = (BuildContext _) => CameraPage();
            //   break;
            //
            // case Routes.drawPage:
            //   final args = settings.arguments as DrawPageArgs;
            //   builder = (BuildContext _) => DrawPage(
            //         imageData: args.uint8list,
            //         loadingWidget: args.widget,
            //       );
            //   break;
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
