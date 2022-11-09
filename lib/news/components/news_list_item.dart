import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/detail/view/view.dart';
import 'package:newsapp/news/models/news.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => DetailPage(
                  article: article,
                ))));
      },
      child: Material(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: article.urlToImage,
            ),
            ListTile(
              title: Text(article.title),
              isThreeLine: true,
              subtitle: Text(article.description),
              dense: true,
            )
          ],
        ),
      ),
    );
  }
}
