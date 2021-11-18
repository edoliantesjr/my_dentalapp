import 'package:flutter/material.dart';

class TextFormStyles {
  static const normalBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.grey, width: 1));

  static const errorBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD32F2F), width: 1));
}
