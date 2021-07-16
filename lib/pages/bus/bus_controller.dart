import 'package:get/get.dart';

class BusController extends GetxController {
  final String title = 'Home Title';
  String formattedDate = '';
  String nearStation = '';

  void setDate(date) {
    formattedDate = date;
    update();
  }

  void setStation(station) {
    nearStation = station;
    update();
  }
}
