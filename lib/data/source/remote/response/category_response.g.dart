// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) {
  return CategoryResponse(
    categories: (json['categories'] as List<dynamic>)
        .map((e) => CategorieItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

CategorieItem _$CategorieItemFromJson(Map<String, dynamic> json) {
  return CategorieItem(
    idCategory: json['idCategory'] as String,
    strCategory: json['strCategory'] as String,
    strCategoryDescription: json['strCategoryDescription'] as String,
    strCategoryThumb: json['strCategoryThumb'] as String,
  );
}

Map<String, dynamic> _$CategorieItemToJson(CategorieItem instance) =>
    <String, dynamic>{
      'idCategory': instance.idCategory,
      'strCategory': instance.strCategory,
      'strCategoryThumb': instance.strCategoryThumb,
      'strCategoryDescription': instance.strCategoryDescription,
    };
