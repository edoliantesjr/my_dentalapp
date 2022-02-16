import 'dart:io';

import 'package:dentalapp/models/appointment_model/appoinment_model.dart';
import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
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

  Future<dynamic> addPatient({required Patient patient});

  Stream<UserModel> getUserAccountDetails();

  Stream<List<Patient>> getPatients();

  Future<List<Patient>> searchPatient(String query);

  Future<dynamic>? addMedicine(
      {required Medicine medicine, required String image});

  Future<List<Medicine>> searchMedicine(String query);

  Stream<List<Medicine>> getMedicineList();

  Future<dynamic>? addProcedure({required Procedure procedure});

  Future<List<Procedure>> searchProcedure(String query);

  Stream<List<Procedure>> getProcedureList();

  Future<void> createAppointment(AppointmentModel appointment);

  Future<ImageUploadResult> uploadMedicineImage(
      {required File imageToUpload, required String genericName});
}