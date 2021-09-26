import 'package:flutter/material.dart';
import '../constants/application_constants.dart';
import '../extensions/context_extension.dart';
import '../modules/movies/models/movie.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;
  const MovieDetailView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.originalTitle.toString())),
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingLow,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                    image: NetworkImage(ApplicationConstants.imageBaseUrl +
                        movie.posterPath.toString())),
              ),
              SizedBox(height: context.lowValue),
              Text(
                movie.overview.toString(),
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
