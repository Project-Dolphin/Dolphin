import 'package:get/get.dart';

import 'package:getx_app/pages/bus/bus_controller.dart';
import 'package:getx_app/pages/calendar/calendar_controller.dart';

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<BusController>(() => BusController());
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
