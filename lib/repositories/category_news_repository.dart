import 'package:dartz/dartz.dart';
import 'package:news_application_bloc/datasources/category_news_datasource.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/exceptions/api_exception.dart';
import 'package:news_application_bloc/model/news_model.dart';

abstract class ICategoryNewsRepository {
  Future<Either<String, List<NewsModel>>> getSpecificCategoryNews(
      String category);
}

class CategoryNewsRepository extends ICategoryNewsRepository {
  final ICategoryNewsDatasource _categoryNewsDatasource = serviceLocator.get();
  @override
  Future<Either<String, List<NewsModel>>> getSpecificCategoryNews(
      String category) async {
    try {
      var respnse =
          await _categoryNewsDatasource.getSpecificCategoryNews(category);
          return right(respnse);
    } on ApiException catch (e) {
      return left(e.message ?? 'Error has been Occuard');
    }
  }
}
