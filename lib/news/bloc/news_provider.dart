// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'news_bloc.dart';
// import 'news_state.dart';
// class NewsView extends StatelessWidget {
//   const NewsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // ignore: close_sinks
//     final newsBloc = BlocProvider.of<NewsBloc>(context);

//     final scaffold = Scaffold(
//       body: BlocBuilder<NewsBloc, NewsState>(
//         buildWhen: (pre, current) => true,
//         builder: (context, state) {
//           return Center(
//             child: Text("Hi...Welcome to BLoC"),
//           );
//         },
//       ),
//     );

//     return MultiBlocListener(
//       listeners: [
//         BlocListener<NewsBloc, NewsState>(
//           listenWhen: (pre, current) => pre.error != current.error,
//           listener: (context, state) {
//             if (state.error?.isNotEmpty ?? false)
//               print("ERROR: ${state.error}");
//           },
//         ),
//       ],
//       child: scaffold,
//     );
//   }
// }
