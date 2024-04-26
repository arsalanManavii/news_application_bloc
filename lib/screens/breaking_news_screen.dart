import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_event.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_state.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/widets/detail_card_widget.dart';

class BreakingNewsScreen extends StatefulWidget {
  const BreakingNewsScreen({super.key});

  @override
  State<BreakingNewsScreen> createState() => _BreakingNewsScreenState();
}

class _BreakingNewsScreenState extends State<BreakingNewsScreen> {
  @override
  void initState() {
      super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeRequestDataEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title:const Text(
          'Breaking News',
          style:  TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc,HomeState>(
          builder: (context, state) {
            return getUi(state);
          },
        ),
      ),
    );
  }
}

Widget getUi(HomeState state) {
  if (state is HomeLoadingState) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if (state is HomeResponseState) {
    return state.breakingNews.fold(
      (errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
      (specificCategoryNews) {
        var list = validation(specificCategoryNews);
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return DetailWidget(newsModel: list[index]);
          },
        );
      },
    );
  }

  return const Center(
    child: Text('Nothing to show'),
  );
}

List<NewsModel> validation(List<NewsModel> list) {
  List<NewsModel> news = [];

  news = list.where(
    (element) {
      if (element.author != null &&
          element.urlToImage != null &&
          element.content != null) {
        return true;
      } else {
        return false;
      }
    },
  ).toList();

  return news;
}