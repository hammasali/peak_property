import 'package:firebase_auth/firebase_auth.dart';
import 'package:peak_property/services/providers/firebase_method.dart';

class FirebaseRepo {
  static final FirebaseRepo instance = FirebaseRepo._instance();

  FirebaseRepo._instance();

  final FirebaseMethod _firebaseMethod = FirebaseMethod();

  /// =========== AUTH ================

  Future<bool> authSignIn() async => await _firebaseMethod.isSignedIn();

  Future<void> resetPassword(String email) async =>
      await _firebaseMethod.resetPassword(email);

  Future<void> signOutUser() async => await _firebaseMethod.signOutUser();

  User? getCurrentUser() => _firebaseMethod.getCurrentUser();

  Future<UserCredential> signInWithGoogle() async =>
      await _firebaseMethod.signInWithGoogle();

  Future<User?> createUser(String email, String password) async =>
      await _firebaseMethod.createUser(email, password);

  Future<User?> signInUser(String email, String password) async =>
      await _firebaseMethod.signInUser(email, password);

  Future<bool> authenticateNewUser(String? email) async =>
      await _firebaseMethod.authenticateNewUser(email);

  /// =============== DATABASE ==============

  Future<void> addNewUserData(var model) async =>
      await _firebaseMethod.addNewUserData(model);
}
