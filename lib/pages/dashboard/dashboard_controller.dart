import 'package:get/get.dart';
import 'package:oceanview/pages/calendar/calendar_controller.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    if (index == 3) {
      setFirstCalendarIndex();
    }
    update();
  }

  setFirstCalendarIndex() {
    Get.put(CalendarController());
    Get.find<CalendarController>()
        .carouselController
        .animateToPage(DateTime.now().month - 2);
  }
}
