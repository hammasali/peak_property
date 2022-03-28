import 'dart:core';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/business_logic/cubit/registration_cubit/registration_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/core/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _name, _password;

  bool _isValidEmail = false;
  bool _isValidName = false;
  bool _isValidPassword = false;
  bool _isAgreeWitRules = false;
  bool _isNewsLetter = false;

  @override
  void initState() {
    _email = '';
    _name = '';
    _password = '';
    super.initState();
  }

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateName(String value) {
    if (value.trim().isEmpty || value.trim().length < 3) return false;

    return true;
  }

  String get _invalidPass => MyApp.invalidPassError;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationSuccessfulState) {
          Navigator.pushNamedAndRemoveUntil<dynamic>(
            context,
            Routes.appNavigation,
            (route) => false, //if you want to disable back feature set to false
          );
        } else if (state is RegistrationUnsuccessfulState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message.toString())));
        }
      },
      child: Scaffold(
        backgroundColor: MyApp.kDefaultBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: MyApp.kDefaultPadding,
              right: MyApp.kDefaultPadding,
              top: MyApp.kDefaultPadding * 2,
            ),
            child: SingleChildScrollView(
              child: FadedScaleAnimation(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        FontAwesomeIcons.arrowLeft,
                        size: MyApp.kDefaultIconSize,
                      ),
                    ),
                    const SizedBox(height: MyApp.kDefaultPadding * 3),
                    const Padding(
                      padding: EdgeInsets.only(left: MyApp.kDefaultPadding / 2),
                      child: Text(
                        MyApp.registrationTxt,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MyApp.kDefaultFontSize * 2,
                            color: MyApp.kDefaultTextColorBlack),
                      ),
                    ),
                    const SizedBox(height: MyApp.kDefaultPadding * 2),
                    Container(
                      padding: const EdgeInsets.all(MyApp.kDefaultPadding * 2),
                      decoration: BoxDecoration(
                        color: MyApp.kDefaultBackgroundColorWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //=======================NAME FIELD===================
                            TextFormField(
                              onChanged: (value) {
                                bool check = validateName(value);
                                setState(() {
                                  _isValidName = check;
                                });
                              },
                              onSaved: (value) => _name = value!,
                              validator: (value) =>
                                  (value!.trim().isEmpty || !_isValidName)
                                      ? MyApp.invalidNameError
                                      : null,
                              decoration: InputDecoration(
                                suffixIcon: _isValidName
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: MyApp.kDefaultCheckColor,
                                        size: MyApp.kDefaultIconSize - 10,
                                      )
                                    : null,
                                labelText: MyApp.fullNameTxt,
                              ),
                            ),

                            //=======================EMAIL FIELD======================
                            TextFormField(
                              onChanged: (value) {
                                bool check = EmailValidator.validate(value);
                                setState(() {
                                  _isValidEmail = check;
                                });
                              },
                              onSaved: (value) {
                                _email = value!;
                              },
                              validator: (value) =>
                                  (value!.trim().isEmpty || !_isValidEmail)
                                      ? MyApp.invalidEmailError
                                      : null,
                              decoration: InputDecoration(
                                suffixIcon: _isValidEmail
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: MyApp.kDefaultCheckColor,
                                        size: MyApp.kDefaultIconSize - 10,
                                      )
                                    : null,
                                labelText: MyApp.emailTxt,
                              ),
                            ),

                            //=======================PASSWORD FIELD===================
                            TextFormField(
                              onChanged: (value) {
                                bool check = validatePassword(value);
                                setState(() {
                                  _isValidPassword = check;
                                });
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                              validator: (value) =>
                                  (value!.trim().isEmpty || !_isValidPassword)
                                      ? _invalidPass
                                      : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                suffixIcon: _isValidPassword
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: MyApp.kDefaultCheckColor,
                                        size: MyApp.kDefaultIconSize - 10,
                                      )
                                    : null,
                                labelText: MyApp.passwordTxt,
                              ),
                            ),
                            const SizedBox(height: MyApp.kDefaultPadding),

                            //=======================CHECK BOX======================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: _isAgreeWitRules,
                                    activeColor: MyApp.kDefaultCheckColor,
                                    checkColor:
                                        MyApp.kDefaultBackgroundColorWhite,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAgreeWitRules = !_isAgreeWitRules;
                                      });
                                    }),
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        color: MyApp.kDefaultTextColorBlack),
                                    children: [
                                      TextSpan(
                                        text: '${MyApp.agreeWithTxt} ',
                                      ),
                                      TextSpan(
                                        text: MyApp.theRulesTxt,
                                        style: TextStyle(
                                          color: MyApp.kDefaultTextColorBlue,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: _isNewsLetter,
                                    activeColor: MyApp.kDefaultCheckColor,
                                    checkColor:
                                        MyApp.kDefaultBackgroundColorWhite,
                                    onChanged: (value) {
                                      setState(() {
                                        _isNewsLetter = !_isNewsLetter;
                                      });
                                    }),
                                const Expanded(
                                    child: Text(
                                  MyApp.checkBox2Txt,
                                  style: TextStyle(
                                      color: MyApp.kDefaultTextColorBlack),
                                )),
                              ],
                            ),
                            const SizedBox(height: MyApp.kDefaultPadding),

                            //=======================SIGN UP BUTTON=================

                            BlocBuilder<RegistrationCubit, RegistrationState>(
                                bloc:
                                    BlocProvider.of<RegistrationCubit>(context),
                                builder: (context, state) {
                                  if (state is RegistrationLoadingState) {
                                    return getCircularProgress();
                                  }
                                  return CustomButton(
                                    width: double.infinity,
                                    label: MyApp.signUpTxt,
                                    padding: MyApp.kDefaultPadding / 1.5,
                                    onTap: () {
                                      if (_isAgreeWitRules) {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          BlocProvider.of<RegistrationCubit>(
                                                  context)
                                              .signUpButtonPressedEvent(
                                                  _email, _password, _name);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(MyApp.scaffoldMsg),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),

                    // =============== Or Continue Google ========
                    Container(
                      margin: const EdgeInsets.only(top: MyApp.kDefaultPadding),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(MyApp.orContinueWithTxt),
                          const SizedBox(height: MyApp.kDefaultPadding),
                          BlocBuilder<RegistrationCubit, RegistrationState>(
                              bloc: BlocProvider.of<RegistrationCubit>(context),
                              builder: (context, state) {
                                if (state is RegistrationGoogleLoadingState) {
                                  return getCircularProgress();
                                }
                                return Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.google,
                                      size: MyApp.kDefaultIconSize + 5,
                                      color: MyApp.kDefaultGoogleIconColor,
                                    ),
                                    onPressed: () =>
                                        BlocProvider.of<RegistrationCubit>(
                                                context)
                                            .googleSignInEvent(),
                                  ),
                                );
                              }),

                          const SizedBox(height: MyApp.kDefaultPadding * 2),

                          // ========== Already Have An Account ===============
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('${MyApp.alreadyHaveAnAccountTxt} '),
                              InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(Routes.signIn),
                                child: const Text(
                                  MyApp.signInTxt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: MyApp.kDefaultTextColorBlack),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
