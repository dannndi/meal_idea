import 'package:hive/hive.dart';
import 'package:meal_idea/data/source/local/entity/meal_detail_entity.dart';

class HiveServices {
  static HiveServices instance() => HiveServices();

  Future<List<MealDetailEntity>> getFavorite() async {
    List<MealDetailEntity> _list = [];
    var favoriteBox = await Hive.openBox<MealDetailEntity>("favorite");
    _list = favoriteBox.values.toList();
    favoriteBox.close();
    return _list;
  }

  Future<void> addFavorite(MealDetailEntity data) async {
    var favoriteBox = await Hive.openBox<MealDetailEntity>("favorite");
    await favoriteBox.add(data);
    favoriteBox.close();
  }

  Future<void> deleteFavorite(String id) async {
    var favoriteBox = await Hive.openBox<MealDetailEntity>("favorite");
    var data = favoriteBox.values.firstWhere((meal) => meal.idMeal == id);
    await data.delete();
    favoriteBox.close();
  }

  Future<MealDetailEntity?> checkFavorite(String id) async {
    MealDetailEntity? _result;
    try {
      var favoriteBox = await Hive.openBox<MealDetailEntity>("favorite");
      _result = favoriteBox.values.firstWhere((meal) => meal.idMeal == id);
      favoriteBox.close();
    } catch (e) {
      _result = null;
    }
    return _result;
  }
}
