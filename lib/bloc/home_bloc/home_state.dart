import 'package:dartz/dartz.dart';
import 'package:news_application_bloc/model/news_model.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<NewsModel>> breakingNews;
  Either<String, List<NewsModel>> trendingNews;
  HomeResponseState(this.breakingNews, this.trendingNews);
}
