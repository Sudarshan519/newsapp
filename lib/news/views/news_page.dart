import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/news/bloc/news_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/news/bloc/news_event.dart';
import 'package:newsapp/news/views/news_list.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News")),
      body: BlocProvider(
        create: (_) => NewsBloc(context, http.Client())..add(NewsFetched()),
        child: const NewsList(),
      ),
    );
  }
}
