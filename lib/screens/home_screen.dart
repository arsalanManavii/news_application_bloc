import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/detail_bloc/detail_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_event.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_state.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/model/category_model.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/screens/breaking_news_screen.dart';
import 'package:news_application_bloc/screens/detail_screen.dart';
import 'package:news_application_bloc/screens/trending_news_screen.dart';
import 'package:news_application_bloc/screens/web_view_screen.dart';
import 'package:news_application_bloc/utility/utility.dart';
import 'package:news_application_bloc/widets/cached_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller;
  late List<CategoryModel> categories;
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeRequestDataEvent());
    controller = PageController(viewportFraction: 0.8);
    categories = Utility.getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CategoryItem(categories: categories),
            ),
            getBreakingNewsTitle(),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is HomeResponseState) {
                  return state.breakingNews.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                        child: Text(errorMessage),
                      );
                    },
                    (breakingNews) {
                      var list = validation(breakingNews);
                      return BreakingNewsCards(
                        controller: controller,
                        breakingNews: list,
                      );
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Not loading the content !!'),
                  ),
                );
              },
            ),
            _getTrendingNewsTitle(),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return SliverList.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Skeletonizer(
                        enabled: true,
                        child: Card(
                          elevation: 1,
                          margin: const EdgeInsets.only(
                              left: 14.0, right: 14.0, bottom: 14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedImage(
                                  imageUrl:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdP7mm_GbNma9QTEgmDPy3QpU9Q0s_0Os3907vjSRFIQ&s',
                                  height: 130.0,
                                  width: 130.0,
                                  radius: 10.0,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child: const Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child: const Text(
                                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is HomeResponseState) {
                  return state.trendingNews.fold(
                    (errorMessage) {
                      return SliverToBoxAdapter(
                        child: Text(errorMessage),
                      );
                    },
                    (response) {
                      var list = validation(response);
                      return TrendingNewsCardWidget(trendingNews: list);
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('Not loading the content !!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTrendingNewsTitle() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            const Text(
              'Trending News!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => HomeBloc(),
                        child: const TrendingNewsScreen(),
                      ),
                    ));
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBreakingNewsTitle() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 25.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            const Text(
              'Breaking News!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        create: (context) => HomeBloc(),
                        child: const BreakingNewsScreen()),
                  ),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakingNewsCards extends StatelessWidget {
  List<NewsModel> breakingNews;
  var controller;
  BreakingNewsCards({
    super.key,
    required this.controller,
    required this.breakingNews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 240.0,
        child: PageView.builder(
          controller: controller,
          itemCount: breakingNews.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                      url: breakingNews[index].url!,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CachedImage(
                      imageUrl: breakingNews[index].urlToImage!,
                      height: 240.0,
                      width: MediaQuery.of(context).size.width,
                      radius: 10.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 150.0, left: 10.0, right: 10.0),
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 8.0),
                    width: MediaQuery.of(context).size.width,
                    height: 240.0,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Text(
                      breakingNews[index].title!,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  List<CategoryModel> categories;
  CategoryItem({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 30.0),
      child: SizedBox(
        height: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => DetailBloc(),
                        child: DetailScreen(
                          category: categories[index].title,
                        ),
                      ),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                      child: Image.asset(
                        categories[index].image,
                        height: 60.0,
                        width: 120.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: 120.0,
                      decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categories[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<NewsModel> validation(List<NewsModel> list) {
  List<NewsModel> news = [];

  news = list.where(
    (element) {
      if (element.author != null &&
          element.urlToImage != null &&
          element.content != null &&
          element.title!.length < 90) {
        return true;
      } else {
        return false;
      }
    },
  ).toList();

  return news;
}

class TrendingNewsCardWidget extends StatelessWidget {
  List<NewsModel> trendingNews;
  TrendingNewsCardWidget({
    super.key,
    required this.trendingNews,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: trendingNews.length ~/ 2,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: false,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WebViewScreen(url: trendingNews[index].url!),
                ),
              );
            },
            child: Card(
              elevation: 1,
              surfaceTintColor: Colors.white,
              margin:
                  const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedImage(
                      imageUrl: trendingNews[index].urlToImage!,
                      height: 120.0,
                      width: 120.0,
                      radius: 10.0,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          trendingNews[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          trendingNews[index].description!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
