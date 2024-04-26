import 'package:flutter/material.dart';
import 'package:news_application_bloc/model/news_model.dart';
import 'package:news_application_bloc/screens/web_view_screen.dart';
import 'package:news_application_bloc/widets/cached_image.dart';

class DetailWidget extends StatelessWidget {
  NewsModel newsModel;
  DetailWidget({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: newsModel.url!),
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CachedImage(
                imageUrl: newsModel.urlToImage!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                radius: 10.0,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(
                children: [
                  Text(
                    newsModel.title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    newsModel.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
