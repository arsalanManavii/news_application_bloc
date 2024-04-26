import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_event.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_state.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/repositories/category_news_repository.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ICategoryNewsRepository _categoryNewsRepository = serviceLocator.get();
  DetailBloc() : super(DetailInitState()) {
    on<DetailRequestEvent>(
      (event, emit) async {
        emit(DetailLoadingState());
        var specificCategoryNews = await _categoryNewsRepository
            .getSpecificCategoryNews(event.category);
        emit(DetailResponseState(specificCategoryNews));
      },
    );
  }
}
