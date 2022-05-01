import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/models/user_info_model.dart';

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

  ///  =========  Database  Add ========== ///

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

  ///  =========  Database  Update ========== ///

  Future<void> updateProfile(UserInfoModel model) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .update(model.toMapUpdateProfile());

    if (model.profilePhoto != null) {
      await firebase_storage.FirebaseStorage.instance
          .ref('profile/${getCurrentUser()!.uid}')
          .putFile(File(model.profilePhoto!.path));
    }
  }

  ///  =========  Database  Get ========== ///

  Query getFixedHomes() {
    return _firestore
        .collectionGroup('properties')
        .where('preference', isEqualTo: 'Fixed Price')
        .orderBy('createdAt', descending: true);
  }

  Query getCurrentUserFixedHomes() {
    return _firestore
        .collection('users')
        .doc(getCurrentUser()?.uid)
        .collection('properties')
        .where('preference', isEqualTo: 'Fixed Price')
        .orderBy('createdAt', descending: true);
  }

  Future<String> downloadAllUserURLs(String uid, String image) async {
    return await firebase_storage.FirebaseStorage.instance
        .ref('property/$uid')
        .child(image)
        .getDownloadURL()
        .catchError((onError) {
      print('On FirebaseStorage Exception $onError');
    });
  }

  DocumentReference getUserProfile(String uid) =>
      _firestore.collection('users').doc(uid);

  Future<String> getUserProfilePic(String uid) async =>
      await firebase_storage.FirebaseStorage.instance
          .ref('profile/${getCurrentUser()!.uid}')
          .getDownloadURL();

  /// ============ DELETE ==============
  Future<void> propertyDelete(UploadModel model) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .collection('properties')
        .doc(model.docId)
        .delete();

    if (model.pickedFilesName!.isNotEmpty) {
      await Future.wait(model.pickedFilesName!.map((image) async =>
          await firebase_storage.FirebaseStorage.instance
              .ref('property/${getCurrentUser()!.uid}')
              .child(image)
              .delete()));
    }
  }

  ///  ----------- BOOKMARK ------------

  Future<void> addBookmark(UploadModel model) async => await _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .collection('bookmarks')
      .doc(model.docId)
      .set(model.toMap());

  Future<void> removeBookmark(var uid) async => await _firestore
      .collection('users')
      .doc(getCurrentUser()!.uid)
      .collection('bookmarks')
      .doc(uid)
      .delete();

  Future<bool> getBookmark(var uid) async {
    var val = await _firestore
        .collection('users')
        .doc(getCurrentUser()!.uid)
        .collection('bookmarks')
        .doc(uid)
        .get();
    return val.exists ? true : false;
  }

  Query fetchAllBookmarks() => _firestore
      .collection('users')
      .doc(getCurrentUser()?.uid)
      .collection('bookmarks')
      .orderBy('createdAt', descending: true);
}
