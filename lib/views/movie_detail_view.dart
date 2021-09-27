import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../modules/movies/viewmodel/movie_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../extensions/context_extension.dart';

class MovieDetailView extends StatelessWidget {
  final MovieViewModel movieViewModel;
  const MovieDetailView({Key? key, required this.movieViewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = movieViewModel.movie.voteAverage ?? 0;

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context, percentage),
    );
  }

  AppBar buildAppBar() =>
      AppBar(title: Text(movieViewModel.movie.originalTitle.toString()));

  SingleChildScrollView buildBody(BuildContext context, double percentage) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          children: [
            buildPosterImage(context, percentage),
            SizedBox(height: context.mediumValue),
            Text(
              movieViewModel.movie.overview.toString(),
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Stack buildPosterImage(BuildContext context, double percentage) {
    return Stack(
      // overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: <Widget>[
              const Center(child: CircularProgressIndicator()),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: movieViewModel.posterImageUrl,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -context.mediumValue,
          left: 20,
          child: CircularPercentIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 60.0,
            lineWidth: 5.0,
            percent: percentage / 10,
            animation: true,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text(
              (percentage * 10).toString() + '%',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            progressColor: Colors.pinkAccent,
          ),
        )
      ],
    );
  }
}
