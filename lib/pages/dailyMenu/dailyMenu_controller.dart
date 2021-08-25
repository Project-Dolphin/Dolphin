import 'package:get/get.dart';

class DailyMenuController extends GetxController {
  int current = 0;

  void setCurrent(response) {
    current = response;
    update();
  }
}
