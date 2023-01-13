import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

late Map<String, dynamic> news;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final res = await http.get(Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=17d26bc7072848a0ad2ff168647a281e'));
  news = json.decode(res.body) as Map<String, dynamic>;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> updateNews() async {
    final res = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=17d26bc7072848a0ad2ff168647a281e'));
    news = json.decode(res.body) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: RefreshIndicator(
        onRefresh: updateNews,
        child: ListView.builder(
          itemBuilder: (ctx, index) => Column(
            children: [
              Container(
                child: news['articles'][index]['urlToImage']==null?null: Image.network(news['articles'][index]['urlToImage']),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                news['articles'][index]['title'],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          itemCount: news['articles'].length,
        ),
      ),
    );
  }
}

class New {
  final String author;
  final String title;
  final String description;
  final String url; //url to image
  final String publishedAt; //try to formate
  final String content;

  New(this.author, this.title, this.description, this.url, this.publishedAt,
      this.content); //try to formate
}
