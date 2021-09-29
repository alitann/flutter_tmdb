import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../extensions/context_extension.dart';
import '../../../style/colors.dart';
import '../viewmodel/movie_view_model.dart';

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
            buildPosterBody(context, percentage),
            const SizedBox(height: 30),
            buildMovieOverview()
          ],
        ),
      ),
    );
  }

  Text buildMovieOverview() {
    return Text(
      movieViewModel.movie.overview.toString(),
      style: const TextStyle(fontSize: 20),
    );
  }

  SizedBox buildPosterBody(BuildContext context, double percentage) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        // overflow: Overflow.visible,
        clipBehavior: Clip.none,
        children: [
          buildImagePoster(),
          buildScoreBackground(),
          buildScoreCircular(context, percentage)
        ],
      ),
    );
  }

  Positioned buildScoreCircular(BuildContext context, double percentage) {
    return Positioned(
      bottom: -30,
      left: 30,
      child: CircularPercentIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        radius: 60.0,
        lineWidth: 4.0,
        percent: percentage / 10,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          (percentage * 10).toString() + '%',
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        progressColor: Colors.pink,
      ),
    );
  }

  Positioned buildScoreBackground() {
    return Positioned(
      bottom: -30,
      left: 30,
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
            color: ColorConstants.primaryColor,
            //Color.fromRGBO(3, 37, 65, .6),
            borderRadius: BorderRadius.all(Radius.circular(60))),
      ),
    );
  }

  ClipRRect buildImagePoster() {
    return ClipRRect(
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
    );
  }
}
