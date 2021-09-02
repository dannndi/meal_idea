import 'package:get/get.dart';
import 'package:meal_idea/data/repository/MealRepo.dart';
import 'package:meal_idea/domain/model/meal_detail.dart';

enum SearchStatus {
  initial,
  loading,
  done,
  error,
}

class SearchController extends GetxController {
  var mealRepo = MealRepo.instance();

  var query = "".obs;
  var searchStatus = SearchStatus.initial.obs;
  var mealsResult = <MealDetail>[].obs;

  void onQueryChange(String value) {
    query.value = value;
  }

  void setSearchStatus(SearchStatus value) {
    searchStatus.value = value;
  }

  void searchMealByKeyword() async {
    setSearchStatus(SearchStatus.loading);
    var result = await mealRepo.getMealsByQuery(query.value);
    if (result != null) {
      if (result.isEmpty) {
        searchStatus.value = SearchStatus.error;
        return;
      }
      mealsResult.value = result;
      searchStatus.value = SearchStatus.done;
    } else {
      searchStatus.value = SearchStatus.error;
    }
  }
}
