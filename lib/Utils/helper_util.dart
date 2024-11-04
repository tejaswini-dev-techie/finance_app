import 'package:flutter/material.dart';

class HelperUtil {
  static String getLangUrl() {
    return "assets/languages/lang_english.json";
  }

  static Color hexToColorTransform(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
