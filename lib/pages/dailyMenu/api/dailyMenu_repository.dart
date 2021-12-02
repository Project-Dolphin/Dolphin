import 'dart:convert';

import 'package:get/get.dart';
import 'package:oceanview/api/api.dart';
import 'package:oceanview/pages/dailyMenu/api/dailyMenu_data.dart';
import 'package:oceanview/pages/dailyMenu/dailyMenu_controller.dart';

class DailyMenuRepository {
  Future<dynamic> mealParse(response) async {
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (responseJson['data']?.length == 52) {
        return [MealData()];
      } else {
        var result = {};
        responseJson['data'].forEach((key, value) {
          result[key] = [...value.map((e) => MealData.fromJson(e))];
        });
        return result;
      }
    } else {
      return [MealData()];
    }
  }

  Future<List<MealData>> dormMealParse(response) async {
    if (response.statusCode == 200) {
      final responseJson = json.decode(utf8.decode(response.bodyBytes));

      if (responseJson['data']?.length == 52) {
        return [MealData()];
      } else {
        final data = responseJson['data'] as Map;
        final List<MealData> result = [];
        for (final name in data.keys) {
          result.add(MealData(type: name, value: data[name]));
        }

        return result;
      }
    } else {
      return [MealData()];
    }
  }

  // Future<List<MealData>> mealDormParse(response) async {
  //   final responseJson = json.decode(utf8.decode(response.bodyBytes));

  //   if (responseJson['data'].length == 52 ||
  //       responseJson['message'] == 'Missing Authentication Token') {
  //     return [MealData()];
  //   } else {
  //     final List<MealData> result = [
  //       ...responseJson['data'].map((e) => MealData.fromJson(e))
  //     ];

  //     return result;
  //   }
  // }

  void menuFill(List listItem, int size) {
    while (listItem.length < size) {
      listItem.add("");
    }
  }

  Future fetchDorm() async {
    return dormMealParse(await FetchAPI().fetchDormTable());
  }

  Future fetchSociety() async {
    return mealParse(await FetchAPI().fetchSocietyTable());
  }

  Future<void> getDailyMenu() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setIsLoading(true);
    Get.find<DailyMenuController>().setSocietyMeal(await fetchSociety());
    Get.find<DailyMenuController>().setNavyMeal(await fetchDorm());
    Get.find<DailyMenuController>().setIsLoading(false);
  }

  getSociety() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setSocietyMeal(await fetchSociety());
    Get.find<DailyMenuController>().setIsLoading(false);
  }

  getDorm() async {
    Get.put(DailyMenuController());
    Get.find<DailyMenuController>().setDormMeal(await fetchDorm());
    Get.find<DailyMenuController>().setIsLoading(false);
  }
}
