import 'dart:async';
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import 'package:newsapp/news/models/news.dart';

import 'news_event.dart';
import 'news_state.dart';

const _newsLimit = 20;
const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(BuildContext context, this.httpClient) : super(const NewsState()) {
    on<NewsFetched>(_onNewsFetched,
        transformer: throttleDroppable(throttleDuration));
  }
  final http.Client httpClient;
  Future<void> _onNewsFetched(
      NewsFetched event, Emitter<NewsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == NewsStatus.initial ||
          state.status == NewsStatus.failure) {
        final news = await _fetchNews();

        return emit(NewsState(
          status: NewsStatus.success,
          news: news,
          hasReachedMax: false,
        ));
      }

      final news = await _fetchNews(state.page);
      news.isEmpty
          ? NewsState(hasReachedMax: true)
          : NewsState(
              status: NewsStatus.success,
              news: List.of(state.news)..addAll(news),
              hasReachedMax: false,
              page: state.page + 1);
    } catch (_) {
      emit(NewsState(status: NewsStatus.failure, news: state.news));
    }
  }

  Future<List<Article>> _fetchNews([int startIndex = 1]) async {
    var headersList = {
      'Accept': '*/*',
      'x-api-key': '839d12bedd95422aa04f816b45d79abc'
    };
    final response = await httpClient.get(
        Uri.parse(
          'https://newsapi.org/v2/' +
              'everything/?q=bitcoin&page=$startIndex&pageSize=20',
          // <String, String>{'page': '$startIndex', 'pageSize': '$_newsLimit'},
        ),
        headers: headersList);
    if (response.statusCode == 200) {
      startIndex++;
      final body = json.decode(response.body)["articles"] as List;

      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Article(
            author: map['author'] ?? '',
            title: map['title'] ?? '',
            description: map['description'] ?? '',
            url: map['url'] ?? '',
            urlToImage: map['urlToImage'] ?? '',
            publishedAt: map['publishedAt'] ?? '',
            content: map['content'] ?? '');
      }).toList();
    } else
      throw Exception('error fetching posts');
  }
}
