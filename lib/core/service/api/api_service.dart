import 'dart:io';

import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/upload_result/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ApiService {
  User? get currentFirebaseUser;

  Future<bool> checkUserStatus();

  Future<void> createUser(UserModel user);

  Future<void> saveFCMToken();

  Future<void> updateUser();

  Future<ImageUploadResult> uploadProfileImage(
      {required File imageToUpload, required String imageFileName});

  Future<ImageUploadResult> uploadPatientProfileImage(
      {required File imageToUpload, required String patientName});

  Future<dynamic> addPatient({required PatientModel patient});

  Stream<UserModel> getUserAccountDetails();
}
