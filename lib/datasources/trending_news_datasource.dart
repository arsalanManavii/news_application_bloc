import 'package:dio/dio.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';

import '../utility/utility.dart';

abstract class ITrendingNewsDatasource {
  Future<List<NewsModel>> getTrendingNews();
}

class TrendingNewsDatasource extends ITrendingNewsDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<NewsModel>> getTrendingNews() async {
    Map<String, String> queryParameters = {
      'q': 'tesla',
      'sortBy': 'popularity',
      'apiKey': Utility.ApiKey,
    };
    try {
      var response =
          await _dio.get('everything', queryParameters: queryParameters);

      var list = response.data['articles']
          .map<NewsModel>((jsonObject) => NewsModel.fromjson(jsonObject))
          .toList();
      return list;
    } on DioException catch (e) {
      throw ApiException(e.response?.statusMessage, e.response?.statusCode);
    }
  }
}
