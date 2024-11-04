import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hp_finance/Utils/helper_util.dart';
import 'package:hp_finance/Utils/print_util.dart';

class AppLanguageUtil with ChangeNotifier {
  static final AppLanguageUtil _appLangUtilInstance =
      AppLanguageUtil._internal();

  factory AppLanguageUtil() {
    return _appLangUtilInstance;
  }

  AppLanguageUtil._internal();

  Map<String, dynamic>? appContent;
  final JsonDecoder _decoder = const JsonDecoder();

  Future<bool> syncLocalizationLanguage(String jsonUrl) async {
    PrintUtil().printMsg("syncing AppLang Content || $jsonUrl");
    return rootBundle.loadString(jsonUrl).then((jsonStr) {
      Map<String, dynamic> fileContent;
      final Map<String, dynamic> res = _decoder.convert(jsonStr);
      fileContent = res;
      appContent = fileContent;
      notifyListeners();
      return true;
    });
  }

  Future<Map<String, dynamic>?> getAppContent() async {
    String? langURL = HelperUtil.getLangUrl();
    if (langURL.isNotEmpty) {
      await syncLocalizationLanguage(langURL);
    }
    return appContent;
  }

  Future<Map<String, dynamic>> getAppContentDetails() async {
    if (appContent != null) {
      return appContent!['common'];
    }
    appContent = await getAppContent();
    return appContent!['common'];
  }
}
