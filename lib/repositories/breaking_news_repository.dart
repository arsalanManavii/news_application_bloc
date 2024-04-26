import 'package:dartz/dartz.dart';
import 'package:news_application_bloc/datasources/breaking_news_datasource.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';

abstract class IBreakingNewsRepository {
  Future<Either<String, List<NewsModel>>> getBreakingNews();
}

class BreakingNewsRepository extends IBreakingNewsRepository {
  final IBreakingNewsDatasource _breakingNewsDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<NewsModel>>> getBreakingNews() async {
    try {
      var response = await _breakingNewsDatasource.getBreakingNews();
      return right(response);
    } on ApiException catch (e) {
      return left(e.message ?? 'Error Here!');
    }
  }
}
