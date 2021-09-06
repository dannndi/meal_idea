import 'package:get/get.dart';
import 'package:meal_idea/data/repository/MealRepo.dart';
import 'package:meal_idea/domain/model/meal_detail.dart';

class FavoriteController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getFavorite();
  }

  var mealRepo = MealRepo.instance();
  Rx<List<MealDetail>?> listFavorite = Rx(null);

  void getFavorite() async {
    listFavorite.value = await mealRepo.getFavoriteMeal();
  }
}
