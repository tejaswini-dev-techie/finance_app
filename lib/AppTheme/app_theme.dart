import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/style_constants.dart';
import 'package:hp_finance/Routing/navigation_service.dart';

import '../main.dart';

class AppTheme extends ChangeNotifier {
  static ThemeData _themeStyle = ThemeData(
    useMaterial3: false,
    fontFamily: StyleConstants.englishFontFamily,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    dividerColor: Colors.black12,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // backgroundColor: const Color(0xFFE5E5E5),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(background: const Color(0xFFE5E5E5)),
  );
  static String fontFamilyLangId = "24";

  ThemeData get themeBasic => _themeStyle;
  String get currentLangID => fontFamilyLangId;

  Future<void> syncAppFont() async {
    _themeStyle = ThemeData(
      useMaterial3: false,
      fontFamily: StyleConstants.englishFontFamily,
      primaryColor: Colors.white,
      brightness: Brightness.light,
      dividerColor: Colors.black12,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(background: const Color(0xFFE5E5E5)),
    );
    notifyListeners();
    AppBuilder.of(NavigationService.navigatorKey.currentContext!)?.rebuild();
  }
}
