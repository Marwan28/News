import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/main.dart';

import 'models/news_repo.dart';
import 'models/web_services.dart';
import 'news_bloc/news_cubit.dart';

class AppRouter {
  late NewsRepo newsRepo;
  late NewsCubit newsCubit;

  AppRouter() {
    newsRepo = NewsRepo(NewsWebServices());
    newsCubit = NewsCubit(newsRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => newsCubit,
            child: const MyHomePage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
    }
  }
}
