import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:peak_property/business_logic/cubit/logout_cubit/logout_cubit.dart';
import 'package:peak_property/business_logic/cubit/registration_cubit/registration_cubit.dart';

import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/theme.dart';

import 'business_logic/cubit/login_cubit/login_cubit.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // WidgetsBinding widgetsBinding =
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthBloc()..add(AuthAppStartedEvent())),
        BlocProvider(create: (context) => RegistrationCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => LogoutCubit()),
      ],
      child: const PeakProperty(),
    );
  }
}

class PeakProperty extends StatelessWidget {
  const PeakProperty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp.kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocBuilder<AuthBloc, AuthState>(
        bloc: BlocProvider.of<AuthBloc>(context),
        builder: (context, state) {
          if (state is AuthSuccessful) {
            return const RouteNavigator(initialRoute: Routes.appNavigation);
          } else if (state is AuthUnSuccessful) {
            return const RouteNavigator(initialRoute: Routes.loginRoot);
          }
          return Container();
        },
      ),
    );
  }
}
