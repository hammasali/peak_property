import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:peak_property/services/models/upload_model.dart';

class FirebaseMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///  =========  Authentication State   ========== ///

  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> resetPassword(String email) async =>
      await _firebaseAuth.sendPasswordResetEmail(email: email);

  Future<void> signOutUser() async {
    _googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }

  Future<bool> authenticateNewUser(String? email) async {
    final result = await Future.value(
        _firestore.collection('users').where('email', isEqualTo: email).get());

    return result.docs.isEmpty ? true : false;
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

  Future<User?> signInUser(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  ///  =========  Database   ========== ///

  Future<void> addNewUserData(var model) async => await _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .set(model);

  Future<void> uploadPropertyData(UploadModel model) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .collection('properties')
        .doc()
        .set(model.toMap());

    if (model.pickedFile != null) {
      await Future.wait(model.pickedFile!.map((image) async =>
      await firebase_storage.FirebaseStorage.instance
          .ref('property/${getCurrentUser()!.uid}')
          .child(image.name)
          .putFile(File(image.path))));
    }
  }
}
