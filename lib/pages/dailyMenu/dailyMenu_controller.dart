import 'package:get/get.dart';

class DailyMenuController extends GetxController {
  final String title = '학사 일정';
  String stat = '';
  bool isLoading = false;
  List<MealData>? societyData = [MealData()];
  List<MealData>? navyData = [MealData()];

  @override
  void onInit() {
    super.onInit();
  }

  void setIsLoading(loading) {
    isLoading = loading;
    update();
  }

  void setSocietyMeal(response) {
    societyData = response;
    update();
  }

  void setNavyMeal(response) {
    navyData = response;
    update();
  }

  void setStat(newStat) {
    stat = newStat;
    update();
  }

  String weekdayToKor(String date) {
    if (date.contains('Mon')) return date.replaceFirst('Mon', '월요일');
    if (date.contains('Tue')) return date.replaceFirst('Tue', '화요일');
    if (date.contains('Wed')) return date.replaceFirst('Wed', '수요일');
    if (date.contains('Thu')) return date.replaceFirst('Thu', '목요일');
    if (date.contains('Fri')) return date.replaceFirst('Fri', '금요일');
    if (date.contains('Sat')) return date.replaceFirst('Sat', '토요일');
    if (date.contains('Sun')) return date.replaceFirst('Sun', '일요일');
    return date;
  }

  String getWeekDay() {
    var now = new DateTime.now();
    return [6, 7].contains(now.weekday)
        ? '주말'
        : [7, 8, 1, 2].contains(now.month)
            ? '방학'
            : '평일';
  }
}

class MealData {
  int? type;
  List<String>? value;

  MealData({this.type = 0, this.value = const ["식단 없음"]});

  MealData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'].split('\n');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.join('\n');
    }

    return data;
  }
}
