import 'package:get/get.dart';

class BusController extends GetxController {
  final String title = 'Home Title';
  String formattedDate = '';

  void setDate(date) {
    formattedDate = date;
    update();
  }
}
