import 'package:dartz/dartz.dart';
import 'package:news_application_bloc/model/news_model.dart';

abstract class DetailState {}

class DetailInitState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailResponseState extends DetailState {
  Either<String, List<NewsModel>> specificCategoryNews;
  DetailResponseState(this.specificCategoryNews);
}
