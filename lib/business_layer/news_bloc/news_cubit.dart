import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/presentation_layer/widgets/news_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news/business_layer/models/news_response_data.dart';
import 'package:hive/hive.dart';

import '../../api_layer/news_repo.dart';
import '../models/article_data.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;
  NewsResponse newsResponse = NewsResponse();

  //SharedPreferences prefs = await SharedPreferences();
  List<String> savedAsPrefs = [];
  List<Articles> savedArticles = [];
  String? currentCountry = 'eg';
  String? currentCategory = 'general';
  List<String> countries = [
    'us',
    'eg',
    'ae',
    'ar',
    'at',
    'au',
    'be',
    'bg',
    'br',
    'ca',
    'ch',
    'cn',
    'co',
    'cu',
    'cz',
    'de',
    'fr',
    'gb',
    'gr',
    'hk',
    'hu',
    'id',
    'ie',
    'il',
    'in',
    'it',
    'jp',
    'kr',
    'lt',
    'lv',
    'ma',
    'mx',
    'my',
    'ng',
    'nl',
    'no',
    'nz',
    'ph',
    'pl',
    'pt',
    'ro',
    'rs',
    'ru',
    'sa',
    'se',
    'sg',
    'si',
    'sk',
    'th',
    'tr',
    'tw',
    'ua',
    've',
    'za'
  ];
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  NewsCubit(this.newsRepo) : super(NewsInitial());

  addNewSavedArticle(Articles article) async {
    var a = article.toJson();
    var articleAsString = json.encode(a);
    savedAsPrefs.insert(0,articleAsString);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedArticles', savedAsPrefs);
    savedAsPrefs.clear();
    savedArticles.clear();
    getAllSaved();
    emit(NewsLoaded(newsResponse));

  }
  Future<List<Articles>> getAllSaved() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedAsPrefs = prefs.getStringList('savedArticles')?? [];
    savedAsPrefs.map((saved) {
      var a = json.decode(saved) as Map<String,dynamic>;
      Articles b = Articles.fromJson(a);
      savedArticles.add(b);
    }).toList();
    print(savedAsPrefs.length);
    print(savedArticles.length);
    print('-------------------------');
    return savedArticles;
  }
  deleteSavedArticle(Articles article)async{
    savedArticles.remove(article);
    savedAsPrefs.remove(json.encode(article.toJson()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('savedArticles', savedAsPrefs);
    savedAsPrefs.clear();
    savedArticles.clear();
    getAllSaved();
    emit(NewsLoaded(newsResponse));

  }


  Future<void> getCountryAndCategory()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentCountry = prefs.getString('currentCountry')?? 'eg';
    currentCategory = prefs.getString('currentCategory')?? 'general';
    getAllNews(currentCountry!,currentCategory!);
  }
  Future<NewsResponse> getAllNews(String country, String category) async{
    newsRepo.getAllNews(country, category).then((news) {
      emit(NewsLoaded(news));
      newsResponse = news;
    });

    return newsResponse;
  }


}
