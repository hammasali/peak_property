import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/main.dart';
import 'package:peak_property/core/my_app.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/";

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

                  //==================FACEBOOK BUTTON==========================
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: MyApp.kDefaultPadding / 2),
                    decoration: BoxDecoration(
                      color: MyApp.kDefaultButtonColorBlack,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.facebookF,
                            color: MyApp.kDefaultFacebookIconColor,
                            size: MyApp.kDefaultIconSize,
                          ),
                          const SizedBox(
                            width: MyApp.kDefaultPadding,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: MyApp.kDefaultTextColorWhite,
                              ),
                              children: [
                                TextSpan(
                                  text: '${MyApp.continueWithTxt} ',
                                ),
                                TextSpan(
                                  text: MyApp.facebookTxt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: MyApp.kDefaultPadding * 2),

                  //====================GOOGLE BUTTON==========================

                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: MyApp.kDefaultPadding / 2),
                    decoration: BoxDecoration(
                      color: MyApp.kDefaultButtonColorBlack,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.google,
                            color: MyApp.kDefaultGoogleIconColor,
                            size: MyApp.kDefaultIconSize,
                          ),
                          const SizedBox(
                            width: MyApp.kDefaultPadding,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: MyApp.kDefaultTextColorWhite,
                              ),
                              children: [
                                TextSpan(
                                  text: '${MyApp.continueWithTxt} ',
                                ),
                                TextSpan(
                                  text: MyApp.googleTxt,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: MyApp.kDefaultPadding * 3),

                  //===========================REGISTER========================
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/register_screen");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: MyApp.kDefaultPadding),
                      decoration: BoxDecoration(
                        color: MyApp.kDefaultBackgroundColor,
                        border: Border.all(color: MyApp.kDefaultButtonBoundaryColor),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Center(
                        child: Text(
                          MyApp.registerWithEmailTxt,
                          style: TextStyle(
                            color: MyApp.kDefaultTextColorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: MyApp.kDefaultPadding * 3),

                  // ============= Already Have An Account SignIn ==============

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('${MyApp.alreadyHaveAnAccountTxt} '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/signIn_screen");
                        },
                        child: const Text(
                          MyApp.signInTxt,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
