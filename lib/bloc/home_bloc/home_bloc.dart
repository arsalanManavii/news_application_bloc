import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_event.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_state.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/repositories/breaking_news_repository.dart';
import 'package:news_application_bloc/repositories/trending_news_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBreakingNewsRepository _breakingNewsRepository = serviceLocator.get();
  final ITrendingNewsRepository _trendingNewsRepository = serviceLocator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeRequestDataEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var breakingNews = await _breakingNewsRepository.getBreakingNews();
        var trendingNews = await _trendingNewsRepository.getTrendingNews();
        emit(HomeResponseState( breakingNews, trendingNews));
      },
    );
  }
}
