import 'package:news/business_layer/models/news_response_data.dart';
import 'package:news/api_layer/web_services.dart';

class NewsRepo{
  final NewsWebServices newsWebServices;

  NewsRepo(this.newsWebServices);

  Future<dynamic> getAllNews(String country,String category) async {
    final news = await newsWebServices.getAllNews(country,category);
    return NewsResponse.fromJson(news);
  }
}