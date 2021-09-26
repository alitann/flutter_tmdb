import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/movies/bloc/movies_bloc.dart';
import 'style/colors.dart';
import 'views/movie_list_view.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(primarySwatch: ColorConstants.primarySwatchColor),
      home: BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc()..add(FirstMoviesEvent()),
          child: const MovieListView()),
      debugShowCheckedModeBanner: false,
    );
  }
}
