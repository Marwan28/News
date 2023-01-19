import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news/models/news_response_data.dart';

import '../models/news_repo.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;
  NewsResponse newsResponse = NewsResponse();

  NewsCubit(this.newsRepo) : super(NewsInitial());
  NewsResponse getAllNews(){
    newsRepo.getAllNews().then((news){
      emit(NewsLoaded(news));
      newsResponse = news;
    });
    return newsResponse;
  }
}
