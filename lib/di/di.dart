import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_application_bloc/datasources/breaking_news_datasource.dart';
import 'package:news_application_bloc/datasources/category_news_datasource.dart';
import 'package:news_application_bloc/datasources/trending_news_datasource.dart';
import 'package:news_application_bloc/repositories/breaking_news_repository.dart';
import 'package:news_application_bloc/repositories/category_news_repository.dart';
import 'package:news_application_bloc/repositories/trending_news_repository.dart';

var serviceLocator = GetIt.instance;

Future<void> getInit() async {
  serviceLocator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'https://newsapi.org/v2/'),
    ),
  );

  //Datasources

  serviceLocator
      .registerSingleton<IBreakingNewsDatasource>(BreakingNewsDatasource());

  serviceLocator
      .registerSingleton<ITrendingNewsDatasource>(TrendingNewsDatasource());

  serviceLocator
      .registerSingleton<ICategoryNewsDatasource>(CategoryNewsDatasource());

  //Repositories

  serviceLocator
      .registerSingleton<IBreakingNewsRepository>(BreakingNewsRepository());

  serviceLocator
      .registerSingleton<ITrendingNewsRepository>(TrendingNewsRepository());

  serviceLocator
      .registerSingleton<ICategoryNewsRepository>(CategoryNewsRepository());
}
