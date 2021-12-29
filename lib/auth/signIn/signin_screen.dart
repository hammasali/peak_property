import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/core/routes.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _password;

  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isForgetPasswordPressed = false;

  @override
  void initState() {
    _email = '';
    _password = '';
    super.initState();
  }

  bool validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  String get _invalidPass => MyApp.invalidPassError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyApp.kDefaultBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: MyApp.kDefaultPadding,
            right: MyApp.kDefaultPadding,
            top: MyApp.kDefaultPadding * 2,
          ),
          child: SingleChildScrollView(
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
                    MyApp.signInTxt,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MyApp.kDefaultFontSize * 2,
                    ),
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
                        // ============= Email Field ==================
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
                        Visibility(
                          visible: !_isForgetPasswordPressed,
                          child: TextFormField(
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
                        ),
                        const SizedBox(height: MyApp.kDefaultPadding - 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //===================FORGET PASSWORD================
                            Visibility(
                              visible: !_isForgetPasswordPressed,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isForgetPasswordPressed = true;
                                  });
                                },
                                child: const Text(
                                  MyApp.forgetPasswordTxt,
                                  style: TextStyle(
                                    fontSize: MyApp.kDefaultFontSize - 4,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: MyApp.kDefaultPadding * 2),

                        //======================SIGNIN BUTTON===================
                        CustomButton(
                          width: double.infinity,
                          label: _isForgetPasswordPressed
                              ? MyApp.verifyTxt
                              : MyApp.signInTxt,
                          padding: MyApp.kDefaultPadding / 1.5,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.appNavigation, (route) => false);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // ================ Or Continue with facebook and google =======
                Container(
                  margin: const EdgeInsets.only(top: MyApp.kDefaultPadding * 4),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(MyApp.continueWithTxt),
                      const SizedBox(height: MyApp.kDefaultPadding),
                      Center(
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            size: (MyApp.kDefaultFontSize * 3) - 3,
                            color: MyApp.kDefaultGoogleIconColor,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                      const SizedBox(height: MyApp.kDefaultPadding * 5),

                      // ============ Don't Have Account =================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(MyApp.doNotHaveAnAccountTxt),
                          InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed(Routes.registration),
                            child: const Text(
                              MyApp.registrationTxt,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
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
    );
  }
}
