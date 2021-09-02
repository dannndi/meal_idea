// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _MealServices implements MealServices {
  _MealServices(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://www.themealdb.com/api/json/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CategoryResponse> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoryResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/1/categories.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MealResponse> getMealByCategory(category) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'c': category};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<MealResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/1/filter.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MealResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchResponse> getMealByQuery(query) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r's': query};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResponse>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/1/search.php',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
