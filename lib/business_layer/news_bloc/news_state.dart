part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState{
  final NewsResponse newsResponse;
  NewsLoaded(this.newsResponse);
}