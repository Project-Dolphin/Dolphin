import 'package:get/get.dart';

import 'package:OceanView/pages/bus/bus_controller.dart';
import 'package:OceanView/pages/calendar/calendar_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BusController>(() => BusController());
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
