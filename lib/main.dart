import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/app_router.dart';
import 'package:news/models/article_data.dart';
import 'package:news/models/news_repo.dart';
import 'package:news/models/news_response_data.dart';
import 'package:news/models/web_services.dart';
import 'package:news/news_bloc/news_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NewsResponse newsResponse;
  NewsResponse searchedNews = NewsResponse();
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      onChanged: (searchedText) {
        addSearchedItemsToSearchedList(searchedText);
      },
      decoration: InputDecoration(hintText: 'Search'),
    );
  }

  void addSearchedItemsToSearchedList(String searchedText) {
    searchedNews.articles = newsResponse.articles!
        .where((element) => element.title!.toLowerCase().contains(searchedText))
        .toList();
    setState(() {});
  }

  List<Widget> _appBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear)),
      ];
    } else {
      return [
        IconButton(onPressed: startSearch, icon: Icon(Icons.search)),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        onRemove: _stopSearching,
      ),
    );
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCubit>(context).getAllNews();
  }

  Widget articel(Articles article) {
    return Column(
      children: [
        Container(
          child: article.urlToImage == null
              ? null
              : Image.network(article.urlToImage!),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          article.title!,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _appBarActions(),
        title: _isSearching ? _buildSearchField() : Text('News'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoaded) {
              newsResponse = state.newsResponse;
              return ListView.builder(
                itemBuilder: (ctx, index) => articel(
                    _searchTextController.text.isEmpty
                        ? newsResponse.articles![index]
                        : searchedNews.articles![index]),
                itemCount: _searchTextController.text.isEmpty
                    ? newsResponse.articles!.length
                    : searchedNews.articles?.length,
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
