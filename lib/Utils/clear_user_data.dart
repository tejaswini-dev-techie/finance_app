import 'package:hp_finance/Utils/print_util.dart';

clearUserData() async {
  try {} catch (e) {
    PrintUtil().printMsg("CLEAR DATA ERROR $e");
  }
  return true;
}
