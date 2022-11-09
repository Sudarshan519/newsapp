import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_bloc.dart';
import 'detail_state.dart';

class NewsDetailProvider extends BlocProvider<NewsDetailBloc> {
  NewsDetailProvider({
    Key? key,
  }) : super(
          key: key,
          create: (context) => NewsDetailBloc(context),
          child: NewsDetailView(),
        );
}

class NewsDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final detailBloc = BlocProvider.of<NewsDetailBloc>(context);

    final scaffold = Scaffold(
      body: BlocBuilder<NewsDetailBloc, NewsDetailState>(
        buildWhen: (pre, current) => true,
        builder: (context, state) {
          return Center(
            child: Text("Hi...Welcome to BLoC"),
          );
        },
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<NewsDetailBloc, NewsDetailState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) print("ERROR: ${state.error}");
          },
        ),
      ],
      child: scaffold,
    );
  }
}
