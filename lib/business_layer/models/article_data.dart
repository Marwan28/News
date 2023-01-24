class Articles {
  Articles({
    Source? source,
    dynamic author,
    String? title,
    dynamic description,
    String? url,
    dynamic urlToImage,
    String? publishedAt,
    dynamic content,}){
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
  }

  Articles.fromJson(dynamic json) {
    _source = json['source'] != null ? Source.fromJson(json['source']) : null;
    _author = json['author'];
    _title = json['title'];
    _description = json['description'];
    _url = json['url'];
    _urlToImage = json['urlToImage'];
    _publishedAt = json['publishedAt'];
    _content = json['content'];
  }
  Source? _source;
  dynamic _author;
  String? _title;
  dynamic _description;
  String? _url;
  dynamic _urlToImage;
  String? _publishedAt;
  dynamic _content;

  Source? get source => _source;
  dynamic get author => _author;
  String? get title => _title;
  dynamic get description => _description;
  String? get url => _url;
  dynamic get urlToImage => _urlToImage;
  String? get publishedAt => _publishedAt;
  dynamic get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_source != null) {
      map['source'] = _source?.toJson();
    }
    map['author'] = _author;
    map['title'] = _title;
    map['description'] = _description;
    map['url'] = _url;
    map['urlToImage'] = _urlToImage;
    map['publishedAt'] = _publishedAt;
    map['content'] = _content;
    return map;
  }

}
class Source {
  Source({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  Source.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}
