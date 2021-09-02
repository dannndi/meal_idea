import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  List<CategorieItem> categories;

  CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}

@JsonSerializable()
class CategorieItem {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  CategorieItem({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryDescription,
    required this.strCategoryThumb,
  });

  factory CategorieItem.fromJson(Map<String, dynamic> json) =>
      _$CategorieItemFromJson(json);
  Map<String, dynamic> toJson() => _$CategorieItemToJson(this);
}
