import 'package:get/get.dart';

class CalendarController1 extends GetxController {
  var counter = 0.obs;

  void increaseCounter() {
    counter.value += 1;
  }
}
