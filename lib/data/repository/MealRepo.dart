import 'package:dio/dio.dart';
import 'package:meal_idea/data/source/local/entity/meal_detail_entity.dart';
import 'package:meal_idea/data/source/local/hive_services.dart';
import 'package:meal_idea/data/source/remote/meal_service.dart';
import 'package:meal_idea/domain/model/category.dart';
import 'package:meal_idea/domain/model/meal.dart';
import 'package:meal_idea/domain/model/meal_detail.dart';

class MealRepo {
  static MealRepo instance() => MealRepo();

  final client = MealServices(Dio());
  final localCLient = HiveServices.instance();

  Future<List<Category>?> getCategory() async {
    List<Category>? categories = [];
    try {
      var response = await client.getCategories();
      categories = response.categories
          .map((categori) => Category(
              idCategory: categori.idCategory,
              strCategory: categori.strCategory,
              strCategoryDescription: categori.strCategoryDescription,
              strCategoryThumb: categori.strCategoryThumb))
          .toList();
    } catch (e) {
      categories = null;
    }
    return categories;
  }

  Future<List<Meal>?> getMealsByCategory(String category) async {
    List<Meal>? meals = [];

    try {
      var response = await client.getMealByCategory(category);
      meals = response.meals
          .map((meal) => Meal(
              idMeal: meal.idMeal,
              strMeal: meal.strMeal,
              strMealThumb: meal.strMealThumb))
          .toList();
    } catch (e) {
      meals = null;
    }
    return meals;
  }

  Future<List<MealDetail>?> getMealsByQuery(String query) async {
    List<MealDetail>? meals = [];

    try {
      var response = await client.getMealByQuery(query);
      meals = response.meals
          .map((meal) => MealDetail(
                idMeal: meal.idMeal,
                strMeal: meal.strMeal,
                strDrinkAlternate: meal.strDrinkAlternate,
                strCategory: meal.strCategory,
                strArea: meal.strArea,
                strInstructions: meal.strInstructions,
                strMealThumb: meal.strMealThumb,
                strTags: meal.strTags,
                strYoutube: meal.strYoutube,
                strIngredient1: meal.strIngredient1,
                strIngredient2: meal.strIngredient2,
                strIngredient3: meal.strIngredient3,
                strIngredient4: meal.strIngredient4,
                strIngredient5: meal.strIngredient5,
                strIngredient6: meal.strIngredient6,
                strIngredient7: meal.strIngredient7,
                strIngredient8: meal.strIngredient8,
                strIngredient9: meal.strIngredient9,
                strIngredient10: meal.strIngredient10,
                strIngredient11: meal.strIngredient11,
                strIngredient12: meal.strIngredient12,
                strIngredient13: meal.strIngredient13,
                strIngredient14: meal.strIngredient14,
                strIngredient15: meal.strIngredient15,
                strIngredient16: meal.strIngredient16,
                strIngredient17: meal.strIngredient17,
                strIngredient18: meal.strIngredient18,
                strIngredient19: meal.strIngredient19,
                strIngredient20: meal.strIngredient20,
                strMeasure1: meal.strMeasure1,
                strMeasure2: meal.strMeasure2,
                strMeasure3: meal.strMeasure3,
                strMeasure4: meal.strMeasure4,
                strMeasure5: meal.strMeasure5,
                strMeasure6: meal.strMeasure6,
                strMeasure7: meal.strMeasure7,
                strMeasure8: meal.strMeasure8,
                strMeasure9: meal.strMeasure9,
                strMeasure10: meal.strMeasure10,
                strMeasure11: meal.strMeasure11,
                strMeasure12: meal.strMeasure12,
                strMeasure13: meal.strMeasure13,
                strMeasure14: meal.strMeasure14,
                strMeasure15: meal.strMeasure15,
                strMeasure16: meal.strMeasure16,
                strMeasure17: meal.strMeasure17,
                strMeasure18: meal.strMeasure18,
                strMeasure19: meal.strMeasure19,
                strMeasure20: meal.strMeasure20,
                strSource: meal.strSource,
                strImageSource: meal.strImageSource,
                strCreativeCommonsConfirmed: meal.strCreativeCommonsConfirmed,
                dateModified: meal.dateModified,
              ))
          .toList();
    } catch (e) {
      meals = null;
    }
    return meals;
  }

  Future<MealDetail?> getMealsById(String id) async {
    MealDetail? meals = MealDetail();
    try {
      var response = await client.getMealById(id);
      var res = response.meals.first;
      meals = MealDetail(
        idMeal: res.idMeal,
        strMeal: res.strMeal,
        strDrinkAlternate: res.strDrinkAlternate,
        strCategory: res.strCategory,
        strArea: res.strArea,
        strInstructions: res.strInstructions,
        strMealThumb: res.strMealThumb,
        strTags: res.strTags,
        strYoutube: res.strYoutube,
        strIngredient1: res.strIngredient1,
        strIngredient2: res.strIngredient2,
        strIngredient3: res.strIngredient3,
        strIngredient4: res.strIngredient4,
        strIngredient5: res.strIngredient5,
        strIngredient6: res.strIngredient6,
        strIngredient7: res.strIngredient7,
        strIngredient8: res.strIngredient8,
        strIngredient9: res.strIngredient9,
        strIngredient10: res.strIngredient10,
        strIngredient11: res.strIngredient11,
        strIngredient12: res.strIngredient12,
        strIngredient13: res.strIngredient13,
        strIngredient14: res.strIngredient14,
        strIngredient15: res.strIngredient15,
        strIngredient16: res.strIngredient16,
        strIngredient17: res.strIngredient17,
        strIngredient18: res.strIngredient18,
        strIngredient19: res.strIngredient19,
        strIngredient20: res.strIngredient20,
        strMeasure1: res.strMeasure1,
        strMeasure2: res.strMeasure2,
        strMeasure3: res.strMeasure3,
        strMeasure4: res.strMeasure4,
        strMeasure5: res.strMeasure5,
        strMeasure6: res.strMeasure6,
        strMeasure7: res.strMeasure7,
        strMeasure8: res.strMeasure8,
        strMeasure9: res.strMeasure9,
        strMeasure10: res.strMeasure10,
        strMeasure11: res.strMeasure11,
        strMeasure12: res.strMeasure12,
        strMeasure13: res.strMeasure13,
        strMeasure14: res.strMeasure14,
        strMeasure15: res.strMeasure15,
        strMeasure16: res.strMeasure16,
        strMeasure17: res.strMeasure17,
        strMeasure18: res.strMeasure18,
        strMeasure19: res.strMeasure19,
        strMeasure20: res.strMeasure20,
        strSource: res.strSource,
        strImageSource: res.strImageSource,
        strCreativeCommonsConfirmed: res.strCreativeCommonsConfirmed,
        dateModified: res.dateModified,
      );
    } catch (e) {
      meals = null;
    }
    return meals;
  }

  Future<List<MealDetail>?> getFavoriteMeal() async {
    List<MealDetail>? meals = [];
    try {
      var response = await localCLient.getFavorite();
      if (response.isNotEmpty) {
        meals = response
            .map((meal) => MealDetail(
                  idMeal: meal.idMeal,
                  strMeal: meal.strMeal,
                  strDrinkAlternate: meal.strDrinkAlternate,
                  strCategory: meal.strCategory,
                  strArea: meal.strArea,
                  strInstructions: meal.strInstructions,
                  strMealThumb: meal.strMealThumb,
                  strTags: meal.strTags,
                  strYoutube: meal.strYoutube,
                  strIngredient1: meal.strIngredient1,
                  strIngredient2: meal.strIngredient2,
                  strIngredient3: meal.strIngredient3,
                  strIngredient4: meal.strIngredient4,
                  strIngredient5: meal.strIngredient5,
                  strIngredient6: meal.strIngredient6,
                  strIngredient7: meal.strIngredient7,
                  strIngredient8: meal.strIngredient8,
                  strIngredient9: meal.strIngredient9,
                  strIngredient10: meal.strIngredient10,
                  strIngredient11: meal.strIngredient11,
                  strIngredient12: meal.strIngredient12,
                  strIngredient13: meal.strIngredient13,
                  strIngredient14: meal.strIngredient14,
                  strIngredient15: meal.strIngredient15,
                  strIngredient16: meal.strIngredient16,
                  strIngredient17: meal.strIngredient17,
                  strIngredient18: meal.strIngredient18,
                  strIngredient19: meal.strIngredient19,
                  strIngredient20: meal.strIngredient20,
                  strMeasure1: meal.strMeasure1,
                  strMeasure2: meal.strMeasure2,
                  strMeasure3: meal.strMeasure3,
                  strMeasure4: meal.strMeasure4,
                  strMeasure5: meal.strMeasure5,
                  strMeasure6: meal.strMeasure6,
                  strMeasure7: meal.strMeasure7,
                  strMeasure8: meal.strMeasure8,
                  strMeasure9: meal.strMeasure9,
                  strMeasure10: meal.strMeasure10,
                  strMeasure11: meal.strMeasure11,
                  strMeasure12: meal.strMeasure12,
                  strMeasure13: meal.strMeasure13,
                  strMeasure14: meal.strMeasure14,
                  strMeasure15: meal.strMeasure15,
                  strMeasure16: meal.strMeasure16,
                  strMeasure17: meal.strMeasure17,
                  strMeasure18: meal.strMeasure18,
                  strMeasure19: meal.strMeasure19,
                  strMeasure20: meal.strMeasure20,
                  strSource: meal.strSource,
                  strImageSource: meal.strImageSource,
                  strCreativeCommonsConfirmed: meal.strCreativeCommonsConfirmed,
                  dateModified: meal.dateModified,
                ))
            .toList();
      }
    } catch (e) {
      meals = null;
    }
    return meals;
  }

  Future<void> addFavorite(MealDetail meal) async {
    await localCLient.addFavorite(MealDetailEntity(
      idMeal: meal.idMeal,
      strMeal: meal.strMeal,
      strDrinkAlternate: meal.strDrinkAlternate,
      strCategory: meal.strCategory,
      strArea: meal.strArea,
      strInstructions: meal.strInstructions,
      strMealThumb: meal.strMealThumb,
      strTags: meal.strTags,
      strYoutube: meal.strYoutube,
      strIngredient1: meal.strIngredient1,
      strIngredient2: meal.strIngredient2,
      strIngredient3: meal.strIngredient3,
      strIngredient4: meal.strIngredient4,
      strIngredient5: meal.strIngredient5,
      strIngredient6: meal.strIngredient6,
      strIngredient7: meal.strIngredient7,
      strIngredient8: meal.strIngredient8,
      strIngredient9: meal.strIngredient9,
      strIngredient10: meal.strIngredient10,
      strIngredient11: meal.strIngredient11,
      strIngredient12: meal.strIngredient12,
      strIngredient13: meal.strIngredient13,
      strIngredient14: meal.strIngredient14,
      strIngredient15: meal.strIngredient15,
      strIngredient16: meal.strIngredient16,
      strIngredient17: meal.strIngredient17,
      strIngredient18: meal.strIngredient18,
      strIngredient19: meal.strIngredient19,
      strIngredient20: meal.strIngredient20,
      strMeasure1: meal.strMeasure1,
      strMeasure2: meal.strMeasure2,
      strMeasure3: meal.strMeasure3,
      strMeasure4: meal.strMeasure4,
      strMeasure5: meal.strMeasure5,
      strMeasure6: meal.strMeasure6,
      strMeasure7: meal.strMeasure7,
      strMeasure8: meal.strMeasure8,
      strMeasure9: meal.strMeasure9,
      strMeasure10: meal.strMeasure10,
      strMeasure11: meal.strMeasure11,
      strMeasure12: meal.strMeasure12,
      strMeasure13: meal.strMeasure13,
      strMeasure14: meal.strMeasure14,
      strMeasure15: meal.strMeasure15,
      strMeasure16: meal.strMeasure16,
      strMeasure17: meal.strMeasure17,
      strMeasure18: meal.strMeasure18,
      strMeasure19: meal.strMeasure19,
      strMeasure20: meal.strMeasure20,
      strSource: meal.strSource,
      strImageSource: meal.strImageSource,
      strCreativeCommonsConfirmed: meal.strCreativeCommonsConfirmed,
      dateModified: meal.dateModified,
    ));
  }

  Future<void> deleteFavorite(MealDetail meal) async {
    await localCLient.deleteFavorite(meal.idMeal.toString());
  }

  Future<bool> checkFavorite(MealDetail meal) async {
    var result = await localCLient.checkFavorite(meal.idMeal.toString());

    if (result != null) {
      return true;
    } else {
      return false;
    }
  }
}
