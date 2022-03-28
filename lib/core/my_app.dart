import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyApp {
  /// ==============  Strings  ================
  static const String kAppTitle = 'Peak Property';
  static const String kAppTitle2 = 'P.P.';
  static const String welcomeTxt = 'Welcome to';
  static const String continueWithTxt = 'Continue with';
  static const String facebookTxt = 'Facebook';
  static const String googleTxt = 'Google';
  static const String registerWithEmailTxt = 'Register with Email';
  static const String alreadyHaveAnAccountTxt = 'Already have an account?';
  static const String doNotHaveAnAccountTxt = 'Don\'t have an account?';
  static const String signInTxt = 'Sign In';
  static const String signUpTxt = 'Sign Up';
  static const String verifyTxt = 'Verify';
  static const String registrationTxt = 'Registration';
  static const String fullNameTxt = 'Full Name';
  static const String emailTxt = 'Email';
  static const String passwordTxt = 'Password';
  static const String agreeWithTxt = 'I agree with';
  static const String theRulesTxt = 'the rules';
  static const String checkBox2Txt = 'I do not want to receive updates';
  static const String orContinueWithTxt = 'Or continue with';
  static const String forgetPasswordTxt = 'Do not remember the password?';

  static const String home = 'Home';
  static const String bookmark = 'Bookmark';
  static const String alerts = 'Alerts';
  static const String chat = 'Chat';

  static const String profile = 'Profile';

  static const String fixed = 'Fixed';
  static const String bid = 'Bid';

  static const String viewProfile = 'View Profile';
  static const String editProfile = 'Edit Profile';
  static const String feedback = 'Feedback';
  static const String rateUs = 'Rate Us';
  static const String logout = 'Logout';
  static const String aboutUs = 'About Us';

  static const String about = 'About';

  static const String confirm = 'Confirm';
  static const String confirmationText =
      'Are you sure you wish to delete this item?';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';

  static const String myProfile = 'My Profile';
  static const String profileInfo = 'Profile Info';
  static const String fullName = 'Full Name';
  static const String username = 'Username';
  static const String bio = 'Bio';
  static const String emailAddress = 'Email Address';
  static const String aboutHint = 'Tell something about property...';
  static const String saveProfile = 'Save Profile';

  static const String scaffoldMsg = '  Please agree to terms.';

  /// =============== Errors ==================
  static const String invalidNameError = 'Invalid name';
  static const String invalidEmailError = 'Invalid email';
  static const String invalidPassError = ' 1 Upper case, 1 Lowercase, 1 Digit';

  /// ==============  Numbers  ===============
  static const double kDefaultPadding = 16;
  static const double kDefaultFontSize = 16;
  static const double kDefaultIconSize = 24;

  /// =============== Colors =================
  static const Color kDefaultBackgroundColor = Color(0xFFF5EEE8);
  static const Color kDefaultBackgroundColorWhite = Color(0xffffffff);

  static const Color kDefaultTextColorBlack = Color(0xFF000000);
  static const Color kDefaultTextColorBlue = Color(0xFF4379DD);
  static const Color kDefaultTextColorWhite = Color(0xFFebebeb);

  static const Color kDefaultFacebookIconColor = Color(0xFF5764D6);
  static const Color kDefaultGoogleIconColor = Color(0xFFF7392E);

  static const Color kDefaultButtonBoundaryColor = Color(0x73000000);

  static const Color kDefaultButtonColorBlack = Color(0xDD000000);

  static const Color kDefaultCheckColor = Color(0xff4caf50);
}

getCircularProgress() {
  return const SpinKitFoldingCube(color: Colors.black54, size: 24.0);
}
