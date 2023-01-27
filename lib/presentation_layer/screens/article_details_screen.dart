import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/business_layer/models/article_data.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatefulWidget {
  const ArticleDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Widget withImage(Articles article) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              // title: Container(
              //   color: Colors.black12,
              //   child: Text(
              //     article.title!,
              //     style: const TextStyle(
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //     maxLines: 1,
              //   ),
              // ),
              background: Hero(
                tag: article.urlToImage,
                child: Image.network(
                  article.urlToImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsetsDirectional.only(
                    top: 20, start: 10, end: 10),
                child: Column(
                  children: [
                    //time
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
                    //source
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                        top: 10,
                      ),
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
                    //title
                    Container(
                      margin: EdgeInsetsDirectional.only(bottom: 10,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 30,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            article.title?? 'Sorry!... Title unavailable',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    //description
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 10,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 26,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            article.description?? 'Sorry!... description unavailable',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    //content
                    Container(
                      margin: const EdgeInsetsDirectional.only(bottom: 10,top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Content',
                            style: TextStyle(
                                fontSize: 26,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            article.content?? 'Sorry!... content unavailable',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60,),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget withoutImage(Articles article) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title!,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsetsDirectional.only(
              top: 20, start: 10, end: 10),
          child: Column(
            children: [
              //time
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
              //source
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: 10,
                ),
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
              //title
              Container(
                margin: EdgeInsetsDirectional.only(bottom: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      article.title?? 'Sorry!... Title unavailable',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              //description
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      article.description?? 'Sorry!... description unavailable',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              //content
              Container(
                margin: const EdgeInsetsDirectional.only(bottom: 10,top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content',
                      style: TextStyle(
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      article.content?? 'Sorry!... content unavailable',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Articles article = ModalRoute.of(context)?.settings.arguments as Articles;
    //print(article);
    if (article.urlToImage == null) {
      return withoutImage(article);
    } else {
      return withImage(article);
    }
  }
}
