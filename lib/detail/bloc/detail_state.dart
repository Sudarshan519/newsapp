import 'package:flutter/material.dart';

@immutable
class NewsDetailState {
  final String error;

  NewsDetailState({
    required this.error,
  });

  static NewsDetailState get initialState => NewsDetailState(
        error: '',
      );

  NewsDetailState clone({
    required String error,
  }) {
    return NewsDetailState(
      error: error ?? this.error,
    );
  }
}
