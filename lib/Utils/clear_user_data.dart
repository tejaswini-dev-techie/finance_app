import 'package:hp_finance/Utils/print_util.dart';
import 'package:hp_finance/Utils/sharedpreferences_util.dart';

clearUserData() async {
  try {
    await SharedPreferencesUtil.clearSharedPrefData();
  } catch (e) {
    PrintUtil().printMsg("CLEAR DATA ERROR $e");
  }
  return true;
}
