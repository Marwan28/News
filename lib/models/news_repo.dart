import 'package:news/models/news_response_data.dart';
import 'package:news/models/web_services.dart';

class NewsRepo{
  final NewsWebServices newsWebServices;

  NewsRepo(this.newsWebServices);

  Future<dynamic> getAllNews() async {
    final news = await newsWebServices.getAllNews();
    return NewsResponse.fromJson(news);
  }
}