import 'package:dio/dio.dart';

class NewsWebServices {
  late Dio dio;

  NewsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2/top-headlines?',
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<dynamic> getAllNews(String country,String category) async {
    try {
      Response response = await dio.get('country=$country&category=$category&apiKey=17d26bc7072848a0ad2ff168647a281e');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}