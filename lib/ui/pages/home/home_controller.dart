import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:meal_idea/data/repository/MealRepo.dart';
import 'package:meal_idea/domain/model/category.dart';
import 'package:meal_idea/domain/model/meal.dart';

enum Status {
  init,
  loading,
  done,
  error,
}

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
    getCategories();
  }

  var mealRepo = MealRepo.instance();
  var username = "".obs;
  var categories = <Category>[].obs;
  var categorieStatus = Status.init.obs;
  var selectedCategorie = Category(
    idCategory: "",
    strCategory: "",
    strCategoryDescription: "",
    strCategoryThumb: "",
  ).obs;
  var meals = <Meal>[].obs;
  var mealStatus = Status.init.obs;

  void getUsername() {
    var profileBox = Hive.box("profile");
    username.value = profileBox.get("username");
  }

  void getCategories() async {
    categorieStatus.value = Status.loading;
    var result = await mealRepo.getCategory();
    if (result != null) {
      categories.addAll(result);
      categorieStatus.value = Status.done;
    } else {
      categorieStatus.value = Status.error;
    }
    setSelectedCategorie(categories[0]);
  }

  void setSelectedCategorie(Category categorie) async {
    selectedCategorie.value = categorie;
    mealStatus.value = Status.loading;
    var result = await mealRepo.getMealsByCategory(categorie.strCategory);
    if (result != null) {
      meals.clear();
      meals.addAll(result);
      mealStatus.value = Status.done;
    } else {
      mealStatus.value = Status.error;
    }
  }
}
