import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class AuthToast {
  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorBlack,
        textColor: colorWhite,
        fontSize: 16.0);
  }
}
