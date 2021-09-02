import 'package:json_annotation/json_annotation.dart';

part 'meal_response.g.dart';

@JsonSerializable()
class MealResponse {
  List<MealItem> meals;

  MealResponse({required this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) =>
      _$MealResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MealResponseToJson(this);
}

@JsonSerializable()
class MealItem {
  String idMeal;
  String strMeal;
  String strMealThumb;

  MealItem({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) =>
      _$MealItemFromJson(json);
  Map<String, dynamic> toJson() => _$MealItemToJson(this);
}
