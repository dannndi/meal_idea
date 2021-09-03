import 'package:get/get.dart';
import 'package:meal_idea/data/repository/MealRepo.dart';
import 'package:meal_idea/domain/model/meal_detail.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';

class DetailMealController extends GetxController {
  var mealRepo = MealRepo.instance();
  Rx<MealDetail?> mealDetail = MealDetail().obs;
  var mealStatus = Status.init.obs;

  void setMealDetail({MealDetail? value, required String id}) async {
    mealStatus.value = Status.loading;
    if (value == null) {
      mealDetail.value = await mealRepo.getMealsById(id);
    } else {
      mealDetail.value = value;
    }
    mealStatus.value = Status.done;
  }
}
