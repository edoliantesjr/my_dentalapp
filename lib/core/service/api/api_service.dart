import 'dart:io';

import 'package:dentalapp/models/upload_result/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';

abstract class ApiService {
  Future<bool> checkUserStatus();

  Future<void> createUser(UserModel user);

  Future<void> saveFCMToken();

  Future<void> updateUser();

  Future<ImageUploadResult> uploadProfileImage(
      {required File imageToUpload, required String imageFileName});
}
