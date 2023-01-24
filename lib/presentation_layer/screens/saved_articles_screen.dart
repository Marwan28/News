import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_layer/models/article_data.dart';
import '../../business_layer/news_bloc/news_cubit.dart';
import '../widgets/news_card.dart';

class SavedArticlesScreen extends StatefulWidget {
  const SavedArticlesScreen({Key? key}) : super(key: key);

  @override
  State<SavedArticlesScreen> createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  late List<Articles> savedArticles;
  @override
  void initState() {
    super.initState();
    //BlocProvider.of<NewsCubit>(context).getAllSaved();
  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: _appBarActions(),
      //   title: _isSearching ? _buildSearchField() : const Text('News'),
      // ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
            savedArticles = BlocProvider.of<NewsCubit>(context).savedArticles;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Article(article: context.read<NewsCubit>().savedArticles[index],inHome: false);
                    },
                    itemCount: context.read<NewsCubit>().savedArticles.length,
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}
