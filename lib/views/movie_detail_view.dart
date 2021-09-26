import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../constants/application_constants.dart';
import '../extensions/context_extension.dart';
import '../modules/movies/models/movie.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;
  const MovieDetailView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = movie.voteAverage ?? 0;

    return Scaffold(
      appBar: AppBar(title: Text(movie.originalTitle.toString())),
      body: buildBody(context, percentage),
    );
  }

  SingleChildScrollView buildBody(BuildContext context, double percentage) {
    return SingleChildScrollView(
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Stack(
                // overflow: Overflow.visible,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                        image: NetworkImage(ApplicationConstants.imageBaseUrl +
                            movie.posterPath.toString())),
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
            }),
            SizedBox(height: context.mediumValue),
            Text(
              movie.overview.toString(),
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
