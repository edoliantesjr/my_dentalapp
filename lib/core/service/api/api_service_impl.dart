import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/medical_history/medical_history.dart';
import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/upload_results/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class ApiServiceImpl extends ApiService {
  final userReference = FirebaseFirestore.instance.collection('users');

  final appointmentReference =
      FirebaseFirestore.instance.collection('appointments');

  final patientReference = FirebaseFirestore.instance.collection('patients');

  final medicineReference = FirebaseFirestore.instance.collection('medicines');

  final procedureReference =
      FirebaseFirestore.instance.collection('procedures');

  @override
  User? get currentFirebaseUser => FirebaseAuth.instance.currentUser;

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
      final profileImageRef = await FirebaseStorage.instance
          .ref('users/${currentFirebaseUser!.uid}/profile-image/profile.jpg');
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success(imageFileName, imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Future<DocumentReference> createPatientID() async {
    return await patientReference.doc();
  }

  @override
  Future<dynamic> addPatient(
      {required Patient patient, required DocumentReference patientRef}) async {
    return patientRef.set(patient.toJson(
        patientId: patientRef.id, dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future<ImageUploadResult> uploadPatientProfileImage(
      {required File imageToUpload, required String patientId}) async {
    try {
      final patientProfileImage = await FirebaseStorage.instance
          .ref('patients/$patientId'
              '/profile-image/profile.jpg')
          .putFile(imageToUpload);

      final imageUrl = await patientProfileImage.ref.getDownloadURL();

      return ImageUploadResult.success('profile.jpg', imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Stream<UserModel> getUserAccountDetails() {
    return userReference
        .doc(currentFirebaseUser!.uid)
        .snapshots()
        .map((data) => UserModel.fromJson(data.data()!));
  }

  @override
  Stream<List<Patient>> getPatients() {
    return patientReference
        .where('field')
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future<List<Patient>> searchPatient(String query) async {
    return await patientReference
        .where("searchIndex", arrayContains: query)
        .get()
        .then((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future? addMedicine({required Medicine medicine, String? image}) async {
    final medicineRef = await medicineReference.doc();
    return medicineRef.set(medicine.toJson(
        id: medicineRef.id,
        image: image ?? '',
        dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future? addProcedure({required Procedure procedure}) async {
    final procedureRef = await procedureReference.doc();
    return procedureRef.set(procedure.toJson(
        id: procedureRef.id, dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Stream<List<Medicine>> getMedicineList() {
    return medicineReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((medicine) => Medicine.fromJson(medicine.data()))
            .toList());
  }

  @override
  Stream<List<Procedure>> getProcedureList() {
    return procedureReference
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((procedure) => Procedure.fromJson(procedure.data()))
            .toList());
  }

  @override
  Future<List<Medicine>> searchMedicine(String query) async {
    //TODO: To Change in the future
    return await medicineReference
        .where('medicineName', isGreaterThanOrEqualTo: query.toTitleCase())
        .where('medicineName',
            isLessThanOrEqualTo: query.toTitleCase() + '\uf8ff')
        .orderBy('medicineName', descending: true)
        .get()
        .then((value) => value.docs
            .map((medicine) => Medicine.fromJson(medicine.data()))
            .toList());
  }

  @override
  Future<List<Procedure>> searchProcedure(String query) async {
    // TODO: To Change in the future
    return await procedureReference
        .where('procedureName', isGreaterThanOrEqualTo: query.toTitleCase())
        .where('procedureName',
            isLessThanOrEqualTo: query.toTitleCase() + '\uf8ff')
        .orderBy('procedureName', descending: true)
        .get()
        .then((value) => value.docs
            .map((procedure) => Procedure.fromJson(procedure.data()))
            .toList());
  }

  @override
  Future<void> createAppointment(AppointmentModel appointment) async {
    final appointmentRef = await appointmentReference.doc();

    return await appointmentRef.set(appointment.toJson(
        patientId: appointment.patient.id,
        appointment_id: appointmentRef.id,
        dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future<ImageUploadResult> uploadMedicineImage(
      {required File imageToUpload, required String genericName}) async {
    try {
      final profileImageRef =
          await FirebaseStorage.instance.ref('medicines/').child(genericName);
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success('imageFileName', imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.code}');
    }
  }

  @override
  Future<List<UserModel>> searchDentist({required String query}) async {
    if (query != '') {
      return await userReference
          .where("searchIndex", arrayContains: query)
          .where('position', isNotEqualTo: 'Staff')
          .orderBy('position', descending: true)
          .get()
          .then((value) => value.docs
              .map((patient) => UserModel.fromJson(patient.data()))
              .toList());
    } else {
      return await userReference
          .where('position', isNotEqualTo: 'Staff')
          .orderBy('position', descending: true)
          .get()
          .then((value) => value.docs
              .map((patient) => UserModel.fromJson(patient.data()))
              .toList());
    }
  }

  @override
  Stream<List<AppointmentModel>> getAppointmentToday() {
    final dateToday =
        DateFormat('yyyy-MM-dd').format(DateTime.now()).toDateTime().toString();
    return appointmentReference
        .where('date', isEqualTo: dateToday)
        .orderBy('startTime', descending: false)
        .snapshots()
        .map((event) => event.docs
            .map((value) => AppointmentModel.fromJson(value.data()))
            .toList());
  }

  @override
  Future<void> deleteAppointment({required String appointmentId}) async {
    return await appointmentReference.doc(appointmentId).delete();
  }

  @override
  Future<void> deleteMedicine({required String medicineId}) async {
    return await medicineReference.doc(medicineId).delete();
  }

  @override
  Future<void> deleteProcedure({required String procedureId}) async {
    return await procedureReference.doc(procedureId).delete();
  }

  @override
  Future<void> deleteUser({required String userId}) async {
    return await userReference.doc(userId).delete();
  }

  @override
  Future<List<AppointmentModel>> getAppointmentAccordingToDate(
      {DateTime? date}) async {
    return await appointmentReference
        .where('date', isEqualTo: date.toString())
        .orderBy('startTime', descending: false)
        .orderBy('appointment_status', descending: true)
        .get()
        .then((value) => value.docs
            .map((appointment) => AppointmentModel.fromJson(appointment.data()))
            .toList());
  }

  @override
  Stream listenToAppointmentChanges() {
    return appointmentReference.snapshots();
  }

  @override
  Future<ImageUploadResult> uploadMedicalHistoryPhoto(
      {required File imageToUpload,
      required String patientId,
      required String fileName}) async {
    try {
      final profileImageRef = await FirebaseStorage.instance
          .ref('patients/${patientId}/medical-history/')
          .child(fileName);
      final uploadTask = profileImageRef.putFile(imageToUpload);
      await uploadTask;
      final imageUrl = await uploadTask.snapshot.ref.getDownloadURL();

      return ImageUploadResult.success(patientId, imageUrl);
    } on FirebaseException catch (e) {
      return ImageUploadResult.error('Image Upload Failed: ${e.message}');
    }
  }

  @override
  Future<List<MedicalHistory>?> getPatientMedicalRecord(
      {required dynamic patientId}) async {
    List<MedicalHistory> medicalHistoryList = [];
    final patient = await patientReference
        .doc(patientId)
        .get()
        .then((value) => Patient.fromJson(value.data()!));
    patient.medicalHistory?.forEach((medicalHistory) {
      //
      medicalHistoryList.add(medicalHistory);
    });
    return medicalHistoryList;
  }
}
