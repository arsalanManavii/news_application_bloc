import 'package:dio/dio.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/utility/utility.dart';

abstract class ICategoryNewsDatasource {
  Future<List<NewsModel>> getSpecificCategoryNews(String category);
}

class CategoryNewsDatasource extends ICategoryNewsDatasource {
  final Dio _dio = serviceLocator.get();

  @override
  Future<List<NewsModel>> getSpecificCategoryNews(String category) async {
    Map<String, String> queryParameters = {
      'country': 'us',
      'apiKey': Utility.ApiKey,
      'category': category
    };
    try {
      var response =
          await _dio.get('top-headlines', queryParameters: queryParameters);
      var resultList = response.data['articles']
          .map<NewsModel>((jsonObject) => NewsModel.fromjson(jsonObject))
          .toList();

      return resultList;
    } on DioException catch (e) {
      throw ApiException(e.response?.statusMessage, e.response?.statusCode);
    } catch (e) {
      throw ApiException('Error', 0);
    }
  }
}
