import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';

class TextBorderStyles {
  static const normalBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Palettes.kcBlueMain1, width: 0.9));

  static const errorBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD32F2F), width: 1));

  static final focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Palettes.kcBlueMain1, width: 2));
}
