import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/main.dart';
import 'package:news/presentation_layer/screens/home_screen.dart';
import 'package:news/presentation_layer/screens/saved_articles_screen.dart';

import 'api_layer/news_repo.dart';
import 'api_layer/web_services.dart';
import 'business_layer/news_bloc/news_cubit.dart';
import 'presentation_layer/screens/article_details_screen.dart';

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
          builder: (context) => BlocProvider<NewsCubit>.value(
            value: newsCubit,
            child: const MyHomePage(),
          ),
        );
      case '/saved':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: newsCubit,
            child: const SavedArticlesScreen(),
          ),
        );
      case '/details':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ArticleDetailsScreen(),
        );
    }
    return null;
  }
}
