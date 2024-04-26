import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_bloc.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_event.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_state.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/widets/detail_card_widget.dart';

class DetailScreen extends StatefulWidget {
  String category;
  DetailScreen({super.key, required this.category});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<DetailBloc>(context)
        .add(DetailRequestEvent(widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.category,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            return getUi(state);
          },
        ),
      ),
    );
  }
}

Widget getUi(DetailState state) {
  if (state is DetailLoadingState) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  if (state is DetailResponseState) {
    return state.specificCategoryNews.fold(
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
