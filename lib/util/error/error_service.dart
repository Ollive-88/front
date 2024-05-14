import 'package:fluttertoast/fluttertoast.dart';

class ErrorService {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }
}
