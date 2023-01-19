import 'package:dio/dio.dart';

class NewsWebServices {
  late Dio dio;

  NewsWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=17d26bc7072848a0ad2ff168647a281e',
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<dynamic> getAllNews() async {
    try {
      Response response = await dio.get('');
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}