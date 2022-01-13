import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/upload_result/image_upload_result.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<dynamic> addPatient({required Patient patient}) async {
    final patientRef = await patientReference.doc();
    return patientRef.set(patient.toJson(
        patientId: patientRef.id, dateCreated: FieldValue.serverTimestamp()));
  }

  @override
  Future<ImageUploadResult> uploadPatientProfileImage(
      {required File imageToUpload, required String patientName}) async {
    try {
      final patientProfileImage = await FirebaseStorage.instance
          .ref('patients/$patientName-${DateTime.now().millisecondsSinceEpoch}'
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
        .orderBy('dateCreated', descending: true)
        .snapshots()
        .map((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future<List<Patient>> searchPatient(String query) async {
    return await patientReference
        .where('lastName', isGreaterThanOrEqualTo: query.toTitleCase())
        .where('lastName', isLessThanOrEqualTo: query.toTitleCase() + '\uf8ff')
        .orderBy('lastName', descending: true)
        .get()
        .then((value) => value.docs
            .map((patient) => Patient.fromJson(patient.data()))
            .toList());
  }

  @override
  Future? addMedicine({required Medicine medicine}) async {
    final medicineRef = await medicineReference.doc();
    return medicineRef.set(medicine.toJson(
        id: medicineRef.id, dateCreated: FieldValue.serverTimestamp()));
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
    // TODO: implement getProcedureList
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
}
