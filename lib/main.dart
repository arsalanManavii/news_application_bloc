import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application_bloc/bloc/home_bloc/home_bloc.dart';
import 'package:news_application_bloc/di/di.dart';
import 'package:news_application_bloc/screens/detail_screen.dart';
import 'package:news_application_bloc/screens/home_screen.dart';

void main() async {
  await getInit();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
