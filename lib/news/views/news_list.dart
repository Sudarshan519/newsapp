import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/news/bloc/news_bloc.dart';
import 'package:newsapp/news/bloc/news_state.dart';
import 'package:newsapp/news/components/widget.dart';

import '../bloc/news_event.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        // if (state.status == NewsStatus.failure)
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(SnackBar(content: Text("Failed to load page")));
        switch (state.status) {
          case NewsStatus.failure:
            return Text("Failed to load page");
          case NewsStatus.success:
            if (state.news.isEmpty) {
              return const Center(child: Text('no posts'));
            } else
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.news.length
                      ? const BottomLoader()
                      : NewsListItem(article: state.news[index]);
                },
                itemCount: state.hasReachedMax
                    ? state.news.length
                    : state.news.length + 1,
                controller: _scrollController,
              );
          case NewsStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NewsBloc>().add(NewsFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
