// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealResponse _$MealResponseFromJson(Map<String, dynamic> json) {
  return MealResponse(
    meals: (json['meals'] as List<dynamic>)
        .map((e) => MealItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MealResponseToJson(MealResponse instance) =>
    <String, dynamic>{
      'meals': instance.meals,
    };

MealItem _$MealItemFromJson(Map<String, dynamic> json) {
  return MealItem(
    idMeal: json['idMeal'] as String,
    strMeal: json['strMeal'] as String,
    strMealThumb: json['strMealThumb'] as String,
  );
}

Map<String, dynamic> _$MealItemToJson(MealItem instance) => <String, dynamic>{
      'idMeal': instance.idMeal,
      'strMeal': instance.strMeal,
      'strMealThumb': instance.strMealThumb,
    };
