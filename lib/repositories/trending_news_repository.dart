import 'package:dartz/dartz.dart';
import 'package:news_application_bloc/datasources/trending_news_datasource.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';

abstract class ITrendingNewsRepository{
  Future<Either<String,List<NewsModel>>> getTrendingNews();
}

class TrendingNewsRepository extends ITrendingNewsRepository{
  final ITrendingNewsDatasource _datasource = serviceLocator.get();  @override
  Future<Either<String, List<NewsModel>>> getTrendingNews() async{
      try {
        var response = await _datasource.getTrendingNews();
        return right(response);
      } on ApiException catch (e) {
        return left(e.message?? 'Error has been occurad!');
      }
  }
}

