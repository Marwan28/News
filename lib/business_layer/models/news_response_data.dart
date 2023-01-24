import './article_data.dart';
class NewsResponse {
  NewsResponse({
      String? status, 
      int? totalResults, 
      List<Articles>? articles,}){
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
}

  set articles(List<Articles>? value) {
    _articles = value;
  }

  NewsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _totalResults = json['totalResults'];
    if (json['articles'] != null) {
      _articles = [];
      json['articles'].forEach((v) {
        _articles?.add(Articles.fromJson(v));
      });
    }
  }
  String? _status;
  int? _totalResults;
  List<Articles>? _articles;

  String? get status => _status;
  int? get totalResults => _totalResults;
  List<Articles>? get articles => _articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalResults'] = _totalResults;
    if (_articles != null) {
      map['articles'] = _articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



