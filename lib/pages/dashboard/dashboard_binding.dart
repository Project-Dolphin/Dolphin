import 'package:get/get.dart';

import 'package:oceanview/pages/bus/bus_controller.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';
import 'package:oceanview/pages/home/home_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<BusController>(() => BusController());
    Get.lazyPut<CalendarController1>(() => CalendarController1());
  }
}
