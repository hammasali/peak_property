import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  ///  =========  Authentication State   ========== ///

  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  void resetPassword(String email) =>
      _firebaseAuth.sendPasswordResetEmail(email: email);

  Future<void> signOutUser() async {
    _googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }

  ///  =========  Registration   ========== ///

  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication? authentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication?.accessToken,
      idToken: authentication?.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<User?> createUser(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return result.user;
  }


  ///  =========  Database   ========== ///

  Future<void> addNewUserData(var model) async => await _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .set(model);
}
