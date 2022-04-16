import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
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
      {required File imageToUpload, required String patientId});

  Future<DocumentReference> createPatientID();

  Future<dynamic> addPatient(
      {required Patient patient, required DocumentReference patientRef});

  Stream<UserModel> getUserAccountDetails();

  Stream<List<Patient>> getPatients();

  Future<List<Patient>> searchPatient(String query);

  Future<dynamic>? addMedicine({required Medicine medicine, String? image});

  Future<List<Medicine>> searchMedicine(String query);

  Stream<List<Medicine>> getMedicineList();

  Future<dynamic>? addProcedure({required Procedure procedure});

  Future<List<Procedure>> searchProcedure(String query);

  Stream<List<Procedure>> getProcedureList();

  Future<void> createAppointment(AppointmentModel appointment);

  Future<ImageUploadResult> uploadMedicineImage(
      {required File imageToUpload, required String genericName});

  Future<List<UserModel>> searchDentist({required String query});

  Stream<List<AppointmentModel>> getAppointmentToday();

  Future<List<AppointmentModel>> getAppointmentAccordingToDate(
      {DateTime? date});

  Future<void> deleteAppointment({required String appointmentId});

  Future<void> deleteProcedure({required String procedureId});

  Future<void> deleteMedicine({required String medicineId});

  Future<void> deleteUser({required String userId});

  Stream listenToAppointmentChanges();

  Future<ImageUploadResult> uploadMedicalHistoryPhoto(
      {required File imageToUpload, required String patientId});

  //Todo 2: add and view photos of patients
  //Todo 3: dental chart of adult and child

}
