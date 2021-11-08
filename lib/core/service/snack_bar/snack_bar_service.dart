import 'package:flutter/material.dart';

abstract class SnackBarService {
  Future<dynamic>? showSnackBar(
    String message, {
    TextButton mainButton,
  });
}
