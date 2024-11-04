import 'package:hp_finance/Constants/app_config_constants.dart';

class PrintUtil {
  static final PrintUtil _printUtilInstance = PrintUtil._internal();

  factory PrintUtil() {
    return _printUtilInstance;
  }

  PrintUtil._internal();

  /* Common Print Method */
  void printMsg(msg) {
    if (AppConfigConstants.enablePrint == true) {
      printWrapped(msg.toString());
    }
  }

  /* To Print Larger Response */
  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach(
          // ignore: avoid_print
          (match) => print(
            match.group(
              0,
            ),
          ),
        );
    // log(text);
  }
}
