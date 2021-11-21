import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final userReference = FirebaseFirestore.instance.collection('users');

final appointmentReference =
    FirebaseFirestore.instance.collection('appointments');

final currentFirebaseUser = FirebaseAuth.instance.currentUser;

final profileImageStorageRef =
    FirebaseStorage.instance.ref('users/${currentFirebaseUser!.uid}/images');
