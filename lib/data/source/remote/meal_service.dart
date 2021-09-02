import 'package:dio/dio.dart';
import 'package:meal_idea/data/source/remote/response/category_response.dart';
import 'package:meal_idea/data/source/remote/response/meal_response.dart';
import 'package:meal_idea/data/source/remote/response/search_response.dart';
import 'package:retrofit/http.dart';

part 'meal_service.g.dart';

@RestApi(baseUrl: "https://www.themealdb.com/api/json/v1")
abstract class MealServices {
  factory MealServices(Dio dio, {String baseUrl}) = _MealServices;

  @GET("/1/categories.php")
  Future<CategoryResponse> getCategories();

  @GET("/1/filter.php")
  Future<MealResponse> getMealByCategory(
    @Query("c") String category,
  );

  @GET("/1/search.php")
  Future<SearchResponse> getMealByQuery(
    @Query("s") String query,
  );
}
