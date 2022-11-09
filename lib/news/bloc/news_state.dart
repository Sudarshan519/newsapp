import 'package:equatable/equatable.dart';
import 'package:newsapp/news/models/news.dart';

enum NewsStatus { initial, success, failure }

class NewsState extends Equatable {
  final NewsStatus status;
  final List<Article> news;
  final bool hasReachedMax;
  final int page;

  const NewsState(
      {this.status = NewsStatus.initial,
      this.news = const <Article>[],
      this.hasReachedMax = false,
      this.page = 1});
  @override
  String toString() {
    return '''NewsState { status: $status, hasReachedMax: $hasReachedMax, news: ${news.length} }''';
  }

  @override
  List<Object?> get props => [status, news, hasReachedMax];
}
