import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/dental_notes/dental_notes.dart';
import 'package:dentalapp/models/medical_history/medical_history.dart';
import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/query_result/query_result.dart';
import 'package:dentalapp/models/tooth_condition/tooth_condition.dart';
import 'package:dentalapp/models/upload_results/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/payment/payment.dart';

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
      {required File imageToUpload,
      required String patientId,
      required String fileName});

  Future<List<MedicalHistory>?> getPatientMedicalRecord(
      {required dynamic patientId});

  Future<void> addToothCondition(
      {required String toothId,
      required dynamic patientId,
      required ToothCondition toothCondition});

  Future<void> addToothDentalNotes(
      {required String toothId,
      required dynamic patientId,
      required DentalNotes dentalNotes,
      required dynamic procedureId});

  Future<List<ToothCondition>?> getDentalConditionList(
      {required dynamic patientId, String? toothId});

  Future<List<DentalNotes>?> getDentalNotesList(
      {required dynamic patientId, String? toothId, bool? isPaid});

  Stream<List<Patient>> getPatientDentalCondition(String patientId);

  Future<void> updateDentalAmountField(
      {required dynamic patientId,
      String? toothId,
      required dental_noteId,
      required dynamic procedureId,
      required String price});

  Future<QueryResult> addPayment({required Payment payment});

  Future<void> updateDentalANotePaidStatus(
      {required dynamic patientId,
      String? toothId,
      required dental_noteId,
      required bool isPaid});
}
