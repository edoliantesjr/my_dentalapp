import 'dart:io';

import 'package:dentalapp/constants/database_strings/database_collection.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/models/upload_result/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ApiServiceImpl extends ApiService {
  @override
  Future<bool> checkUserStatus() async {
    final userDoc = await userReference.doc(currentFirebaseUser!.uid).get();
    if (!userDoc.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
    var userRef = userReference.doc(currentFirebaseUser!.uid);
    userRef.set(user.toJson());
  }

  @override
  Future<void> saveFCMToken() {
    // TODO: implement saveFCMToken
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<ImageUploadResult> uploadProfileImage(
      {required File imageToUpload, required String imageFileName}) async {
    try {
      final profileImageRef = profileImageStorageRef.child(imageFileName);

      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success(imageFileName, imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }
}
