import 'dart:convert';

import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/dailyMenu/api/dailyMenu_data.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';

class DailyMenuRepository {
  Future<List<MealData>> mealParse(response) async {
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (responseJson['data']?.length == 52) {
        return [MealData()];
      } else {
        final List<MealData> result = [
          ...responseJson['data'].map((e) => MealData.fromJson(e))
        ];

        return result;
      }
    } else {
      return [MealData()];
    }
  }

  void menuFill(List listItem, int size) {
    while (listItem.length < size) {
      listItem.add("");
    }
  }

  Future fetchNavy() async {
    return mealParse(await FetchAPI().fetchNavyTable());
  }

  Future fetchSociety() async {
    return mealParse(await FetchAPI().fetchSocietyTable());
  }

  Future fetchDorm() async {
    return mealParse(await FetchAPI().fetchDormTable());
  }

  Future<void> getDailyMenu() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setIsLoading(true);
    Get.find<DailyMenuController>().setSocietyMeal(await fetchSociety());
    Get.find<DailyMenuController>().setNavyMeal(await fetchNavy());
    Get.find<DailyMenuController>().setIsLoading(false);
  }

  getSociety() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setSocietyMeal(await fetchSociety());
    Get.find<DailyMenuController>().setIsLoading(false);
  }

  getNavy() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setNavyMeal(await fetchNavy());
    Get.find<DailyMenuController>().setIsLoading(false);
  }
}
