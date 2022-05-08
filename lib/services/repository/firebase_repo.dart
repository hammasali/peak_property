import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peak_property/services/models/bider_model.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/models/user_info_model.dart';
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

  Future<void> uploadPropertyData(UploadModel model) async =>
      await _firebaseMethod.uploadPropertyData(model);

  Future<void> addBookmark(UploadModel model) async =>
      await _firebaseMethod.addBookmark(model);

  Future<void> removeBookmark(var uid) async =>
      await _firebaseMethod.removeBookmark(uid);

  Future<bool> getBookmark(var uid) async =>
      await _firebaseMethod.getBookmark(uid);

  Query fetchBookmark() => _firebaseMethod.fetchAllBookmarks();

  Future<void> updateProfile(UserInfoModel model) async =>
      await _firebaseMethod.updateProfile(model);

  Query getFixedHomes() => _firebaseMethod.getFixedHomes();

  Query getBidsProperty() => _firebaseMethod.getBidsProperty();

  Query getCurrentUserFixedHomes() =>
      _firebaseMethod.getCurrentUserFixedHomes();

  Future<String> downloadAllUserURLs(String uid, String image) async =>
      _firebaseMethod.downloadAllUserURLs(uid, image);

  DocumentReference getUserProfile(String uid) =>
      _firebaseMethod.getUserProfile(uid);

  Future<String> getUserProfilePic(String uid) async =>
      await _firebaseMethod.getUserProfilePic(uid);

  Future<void> propertyDelete(UploadModel model) async =>
      await _firebaseMethod.propertyDelete(model);

  Future<void> biders(var docId, BidersModel model, var uid) async =>
      await _firebaseMethod.biders(docId, model, uid);

  Query getBiders(var docId, var uid) => _firebaseMethod.getBiders(docId, uid);

  Future<void> addMessageToDB(
          {String? message,
          String? receiverId,
          String? senderName,
          String? senderImageUrl,
          String? receiverName,
          String? receiverImageUrl}) async =>
      _firebaseMethod.addMessageToDB(message, receiverId, senderName,
          senderImageUrl, receiverName, receiverImageUrl);

  Query fetchUserChatRoom() => _firebaseMethod.fetchUserChatRoom();

  Query fetchUserChat(String? uid) => _firebaseMethod.fetchUserChat(uid);

  Future<void> deleteChat(String docId) async =>
      await _firebaseMethod.deleteChat(docId);
}
