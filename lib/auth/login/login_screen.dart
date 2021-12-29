import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyApp.kDefaultBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: MyApp.kDefaultPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: MyApp.kDefaultTextColorBlack,
                        fontSize: MyApp.kDefaultFontSize * 2.5,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '${MyApp.welcomeTxt} \n',
                          style:
                              TextStyle(fontSize: MyApp.kDefaultFontSize * 1.5),
                        ),
                        TextSpan(
                          style: TextStyle(
                            color: MyApp.kDefaultTextColorBlue,
                          ),
                          text: MyApp.kAppTitle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: MyApp.kDefaultPadding * 3),

                  //====================GOOGLE BUTTON==========================

                   const CustomButton(
                    width: double.infinity,
                    padding: MyApp.kDefaultPadding / 2,
                    label: " Continue with ${MyApp.googleTxt}",
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: MyApp.kDefaultGoogleIconColor,
                    ),
                  ),
                  const SizedBox(height: MyApp.kDefaultPadding * 3),

                  //===========================REGISTER========================

                   CustomButton(
                    width: double.infinity,
                    label: MyApp.registerWithEmailTxt,
                    color: MyApp.kDefaultBackgroundColor,
                    textColor: MyApp.kDefaultTextColorBlack,
                    borderColor:  MyApp.kDefaultButtonBoundaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.registration);
                    },
                  ),

                  const SizedBox(height: MyApp.kDefaultPadding * 3),

                  // ============= Already Have An Account SignIn ==============

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('${MyApp.alreadyHaveAnAccountTxt} '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signIn);
                        },
                        child:  Text(
                          MyApp.signInTxt,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
