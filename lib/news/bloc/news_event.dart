import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewsFetched extends NewsEvent {}


