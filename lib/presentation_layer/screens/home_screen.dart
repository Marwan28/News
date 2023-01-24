import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business_layer/models/article_data.dart';
import '../../business_layer/models/news_response_data.dart';
import '../../business_layer/news_bloc/news_cubit.dart';
import '../widgets/drawer.dart';
import '../widgets/news_card.dart';

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

  //late String counrtyDropdownValue;
  //late String categoryDropdownValue;

  Widget _buildSearchField() {
    return TextField(
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Colors.white),
      controller: _searchTextController,
      autofocus: true,
      onChanged: (searchedText) {
        addSearchedItemsToSearchedList(searchedText);
      },
      decoration: const InputDecoration(
          hintText: 'Search', hintStyle: TextStyle(color: Colors.white)),
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
            icon: const Icon(Icons.clear)),
      ];
    } else {
      return [
        IconButton(onPressed: startSearch, icon: const Icon(Icons.search)),
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
    BlocProvider.of<NewsCubit>(context).getCountryAndCategory();
    BlocProvider.of<NewsCubit>(context).getAllSaved();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: _appBarActions(),
        title: _isSearching ? _buildSearchField() : const Text('News'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<NewsCubit>(context).getCountryAndCategory();
          //BlocProvider.of<NewsCubit>(context).getAllNews(BlocProvider.of<NewsCubit>(context).currentCountry!,BlocProvider.of<NewsCubit>(context).currentCategory!);
        },
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoaded) {
              newsResponse = state.newsResponse;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      start: 10,
                      end: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButton(
                            hint: Text(
                              BlocProvider.of<NewsCubit>(context)
                                      .currentCountry ??
                                  'choose country',
                              style: const TextStyle(color: Colors.blue),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: const TextStyle(color: Colors.blue),
                            items: context.read<NewsCubit>().countries.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('currentCountry', value!);
                              context.read<NewsCubit>().getCountryAndCategory();
                            }
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: DropdownButton(
                            hint: Text(
                              BlocProvider.of<NewsCubit>(context)
                                      .currentCategory ??
                                  'choose country',
                              style: const TextStyle(color: Colors.blue),
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: const TextStyle(color: Colors.blue),
                            items: context.read<NewsCubit>().categories.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (value) async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              prefs.setString('currentCategory', value!);
                              context.read<NewsCubit>().getCountryAndCategory();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => Article(
                          article: _searchTextController.text.isEmpty
                              ? newsResponse.articles![index]
                              : searchedNews.articles![index],inHome: true,),
                      itemCount: _searchTextController.text.isEmpty
                          ? newsResponse.articles!.length
                          : searchedNews.articles?.length,
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawer: const MyDrawer(),
    );
  }
}
