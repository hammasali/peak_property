import 'dart:core';
import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peak_property/business_logic/cubit/image_cubit/image_cubit.dart';
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
  XFile? _pickedFile;

  late String _email, _name, _password, _phone, _aboutUs;

  bool _isValidEmail = false;
  bool _isValidName = false;
  bool _isValidPassword = false;
  bool _isValidPhoneNo = false;
  bool _isAgreeWitRules = false;
  bool _isNewsLetter = false;

  @override
  void initState() {
    _email = '';
    _name = '';
    _password = '';
    _phone = '';
    _aboutUs = '';
    super.initState();
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
              bottom: MyApp.kDefaultPadding * 2,
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
                    const SizedBox(height: MyApp.kDefaultPadding),
                    image(),
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
                            BlocBuilder<RegistrationCubit, RegistrationState>(
                              builder: (context, state) {
                                if (state is ValidateNameState) {
                                  _isValidName = state.isValid;
                                }
                                return TextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<RegistrationCubit>(context)
                                        .validateName(value);

                                    // bool check = validateName(value);
                                    //
                                    // setState(() {
                                    //   _isValidName = check;
                                    // });
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
                                );
                              },
                            ),

                            //=======================EMAIL FIELD======================
                            BlocBuilder<RegistrationCubit, RegistrationState>(
                              builder: (context, state) {
                                if (state is ValidateEmailState) {
                                  _isValidEmail = state.isValid;
                                }
                                return TextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<RegistrationCubit>(context)
                                        .validateEmail(value);
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
                                );
                              },
                            ),

                            //=======================PASSWORD FIELD===================
                            BlocBuilder<RegistrationCubit, RegistrationState>(
                              builder: (context, state) {
                                if (state is ValidatePasswordState) {
                                  _isValidPassword = state.isValid;
                                }
                                return TextFormField(
                                  onChanged: (value) {
                                    BlocProvider.of<RegistrationCubit>(context)
                                        .validatePassword(value);
                                  },
                                  onSaved: (value) {
                                    _password = value!;
                                  },
                                  validator: (value) =>
                                      (value!.trim().isEmpty ||
                                              !_isValidPassword)
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
                                );
                              },
                            ),

                            //=======================Phone No FIELD===================
                            BlocBuilder<RegistrationCubit, RegistrationState>(
                              builder: (context, state) {
                                if (state is ValidatePhoneNoState) {
                                  _isValidPhoneNo = state.isValid;
                                }
                                return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    BlocProvider.of<RegistrationCubit>(context)
                                        .validatePhoneNo(value);
                                  },
                                  onSaved: (value) {
                                    _phone = value!;
                                  },
                                  validator: (value) => (value!.trim().isEmpty)
                                      ? 'Invalid Phone No'
                                      : null,
                                  decoration: InputDecoration(
                                    suffixIcon: _isValidPhoneNo
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: MyApp.kDefaultCheckColor,
                                            size: MyApp.kDefaultIconSize - 10,
                                          )
                                        : null,
                                    labelText: 'Phone No',
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: MyApp.kDefaultPadding * 2),

                            //=======================About Us FIELD===================
                            TextFormField(
                              onSaved: (value) {
                                _aboutUs = value!;
                              },
                              validator: (value) => (value!.trim().isEmpty)
                                  ? 'Tell something about your organization'
                                  : null,
                              minLines: 3,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                label: Text(MyApp.about),
                                hintText: MyApp.aboutHint,
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),

                            const SizedBox(height: MyApp.kDefaultPadding),

                            //=======================CHECK BOX======================
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BlocBuilder<RegistrationCubit,
                                    RegistrationState>(
                                  builder: (context, state) {
                                    if(state is AgreeRulesState) {
                                      _isAgreeWitRules = state.isValid;
                                    }
                                    return Checkbox(
                                        value: _isAgreeWitRules,
                                        activeColor: MyApp.kDefaultCheckColor,
                                        checkColor:
                                            MyApp.kDefaultBackgroundColorWhite,
                                        onChanged: (value) {
                                          BlocProvider.of<RegistrationCubit>(
                                              context)
                                              .agreeRules(!_isAgreeWitRules);
                                        });
                                  },
                                ),
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
                                BlocBuilder<RegistrationCubit,
                                    RegistrationState>(
                                  builder: (context, state) {
                                    if (state is UpdateState) {
                                      _isNewsLetter = state.isValid;
                                    }
                                    return Checkbox(
                                        value: _isNewsLetter,
                                        activeColor: MyApp.kDefaultCheckColor,
                                        checkColor:
                                            MyApp.kDefaultBackgroundColorWhite,
                                        onChanged: (value) {
                                          BlocProvider.of<RegistrationCubit>(
                                                  context)
                                              .update(!_isNewsLetter);
                                        });
                                  },
                                ),
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
                                          if (_pickedFile != null) {
                                            BlocProvider.of<RegistrationCubit>(
                                                    context)
                                                .signUpButtonPressedEvent(
                                                    _email,
                                                    _password,
                                                    _name,
                                                    _phone,
                                                    _aboutUs,
                                                    _pickedFile);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Please add profile pic to register'),
                                              ),
                                            );
                                          }
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

  /// ================ Image ================
  image() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: double.infinity,
      alignment: Alignment.center,
      child: FutureBuilder<void>(
        future: BlocProvider.of<ImageCubit>(context).retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return getCircularProgress();
            case ConnectionState.done:
              return _previewImages();
            default:
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Pick image: ${snapshot.error}}',
                  textAlign: TextAlign.center,
                )));
                return _previewImages();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                )));
                return _previewImages();
              }
          }
        },
      ),
    );
  }

  Widget _previewImages() {
    return BlocConsumer<ImageCubit, ImageState>(
        bloc: BlocProvider.of<ImageCubit>(context),
        builder: (context, state) {
          if (state is ProfileImageSuccess) {
            _pickedFile = state.imageFileList;
          }

          return InkWell(
            onTap: () => showSheet(context),
            child: Semantics(
                child: Stack(
                  children: [
                    Semantics(
                        child: FadedScaleAnimation(
                          child: _pickedFile != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(_pickedFile!.path),
                                  ),
                                )
                              : const Icon(Icons.account_circle_outlined,
                                  size: 120),
                        ),
                        label: 'Select Photo'),
                    Positioned(
                      right: 0,
                      top: 7,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                label: 'Select Photo'),
          );
        },
        listener: (context, state) {
          if (state is ImageUnSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Image error: ${state.message}',
              textAlign: TextAlign.center,
            )));
            state.message = null;
          }
        });
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 140.0,
            color: MyApp.kDefaultBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).onImageButtonPressed(
                        ImageSource.gallery,
                        isMultiImage: false,
                        isProfileImage: true);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: MyApp.kDefaultButtonColorBlack,
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).onImageButtonPressed(
                        ImageSource.camera,
                        isProfileImage: true);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: MyApp.kDefaultButtonColorBlack,
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          );
        });
  }
}

// bool validatePassword(String value) {
//   String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
//   RegExp regExp = RegExp(pattern);
//   return regExp.hasMatch(value);
// }
//
// bool validatePhoneNo(String value) {
//   String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//   RegExp regExp = RegExp(pattern);
//   return regExp.hasMatch(value);
// }
//
// bool validateName(String value) {
//   if (value.trim().isEmpty || value.trim().length < 3) return false;
//
//   return true;
// }
