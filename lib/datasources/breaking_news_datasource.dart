import 'package:dio/dio.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/utility/utility.dart';

abstract class IBreakingNewsDatasource {
  Future<List<NewsModel>> getBreakingNews();
}

class BreakingNewsDatasource extends IBreakingNewsDatasource {
  final Dio _dio = serviceLocator.get();
  @override
  Future<List<NewsModel>> getBreakingNews() async {
    Map<String, String> queryParameters = {
      'country': 'us',
      'apiKey': Utility.ApiKey,
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
    }
  }
}
