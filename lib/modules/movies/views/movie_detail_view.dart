import 'package:flutter/material.dart';
import 'package:flutter_tmdb/extensions/context_extension.dart';
import 'package:flutter_tmdb/modules/movies/viewmodel/movie_view_model.dart';
import 'package:flutter_tmdb/style/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
            const SizedBox(height: 30),
            Text(
              movieViewModel.movie.overview.toString(),
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  SizedBox buildPosterImage(BuildContext context, double percentage) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
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
          ),
          Positioned(
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
          )
        ],
      ),
    );
  }
}
