import 'package:get/get.dart';
import 'package:meal_idea/data/repository/MealRepo.dart';
import 'package:meal_idea/domain/model/meal_detail.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';

class DetailMealController extends GetxController {
  var mealRepo = MealRepo.instance();

  Rx<MealDetail?> mealDetail = MealDetail().obs;
  var mealStatus = Status.init.obs;
  var mealIsFavorite = false.obs;
  void setMealDetail({MealDetail? value, required String id}) async {
    mealStatus.value = Status.loading;
    if (value == null) {
      mealDetail.value = await mealRepo.getMealsById(id);
    } else {
      mealDetail.value = value;
    }
    checkFavorite(mealDetail.value!);
    mealStatus.value = Status.done;
  }

  void addFavorite() async {
    if (mealDetail.value != null) {
      await mealRepo.addFavorite(mealDetail.value!);
      mealIsFavorite.value = true;
    }
  }

  void deleteFavorite() async {
    if (mealDetail.value != null) {
      await mealRepo.deleteFavorite(mealDetail.value!);
      mealIsFavorite.value = false;
    }
  }

  void checkFavorite(MealDetail meal) async {
    mealIsFavorite.value = await mealRepo.checkFavorite(meal);
  }
}
