import 'package:flutter/material.dart';
import 'package:newsapp/news/models/models.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.article}) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Column(
        children: [
          Image.network(article.urlToImage),
          ListTile(
            title: Text(article.title),
          ),
          ListTile(
            subtitle: Text(article.description),
          ),
          ListTile(
            subtitle: Text(article.content),
          )
        ],
      ),
    );
  }
}
