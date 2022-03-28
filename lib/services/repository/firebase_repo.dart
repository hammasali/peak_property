import 'package:firebase_auth/firebase_auth.dart';
import 'package:peak_property/services/providers/firebase_method.dart';

class FirebaseRepo {
  static final FirebaseRepo instance = FirebaseRepo._instance();

  FirebaseRepo._instance();

  final FirebaseMethod _firebaseMethod = FirebaseMethod();

  Future<bool> authSignIn() async => await _firebaseMethod.isSignedIn();

  void resetPassword(String email) => _firebaseMethod.resetPassword(email);

  Future<void> signOutUser() async => await _firebaseMethod.signOutUser();

  User? getCurrentUser() => _firebaseMethod.getCurrentUser();

  Future<UserCredential> signInWithGoogle() async =>
      await _firebaseMethod.signInWithGoogle();

  Future<User?> createUser(String email, String password) async =>
      await _firebaseMethod.createUser(email, password);

  Future<void> addNewUserData(var model) async =>
      await _firebaseMethod.addNewUserData(model);
}
