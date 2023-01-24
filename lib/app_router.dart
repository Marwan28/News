import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/main.dart';
import 'package:news/presentation_layer/screens/home_screen.dart';
import 'package:news/presentation_layer/screens/saved_articles_screen.dart';

import 'api_layer/news_repo.dart';
import 'api_layer/web_services.dart';
import 'business_layer/news_bloc/news_cubit.dart';

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
      case '/saved':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => newsCubit,
            child: const SavedArticlesScreen(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
    }
  }
}
