import 'package:flutter/material.dart';

@immutable
abstract class NewsDetailEvent {}

class ErrorEvent extends NewsDetailEvent {
  final String error;

  ErrorEvent(this.error);
}
