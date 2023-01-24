import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news/business_layer/news_bloc/news_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../business_layer/models/article_data.dart';
import 'package:url_launcher/url_launcher.dart';

class Article extends StatelessWidget {
  const Article({Key? key, required this.article, required this.inHome}) : super(key: key);
  final Articles article;
  final bool inHome;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url = 'https://flutter.io';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  /*
  * Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),),
      elevation: 10,
      margin: EdgeInsetsDirectional.all(10),
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(0,0,0,10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Container(
              child: article.urlToImage == null
                  ? null
                  : Image.network(article.urlToImage!,fit: BoxFit.fitHeight,),
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
        ),
      ),
    )*/

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      elevation: 10,
      margin: const EdgeInsetsDirectional.all(10),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Column(
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                ),
              ),
            Container(
              margin:
                  const EdgeInsetsDirectional.only(top: 5, start: 10, end: 10),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Time: ${DateFormat('dd-MM-yyyy hh:mm aa').format(DateTime.parse(article.publishedAt!))}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: (){
                              if(inHome){
                                context.read<NewsCubit>().addNewSavedArticle(article);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('save button pressed',),),);
                              }else{
                                context.read<NewsCubit>().deleteSavedArticle(article);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('delete button pressed',),),);
                              }
                              },
                            icon: Icon(inHome?
                              Icons.save:Icons.delete,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.source_outlined,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  article.source?.name != null
                                      ? 'Source: ${article.source!.name}'
                                      : 'Source: Unknown source',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () async =>
                              _launchInBrowser(Uri.parse(article.url!)),
                          child: const Text('Go To'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsetsDirectional.only(bottom: 10),
                    child: Text(
                      article.title!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
