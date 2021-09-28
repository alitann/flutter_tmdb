import 'package:flutter/material.dart';
import '../../constants/navigation_constants.dart';
import '../../exception/navigate_exception.dart';
import 'no_found_navigation.dart';
import '../../../modules/movies/viewmodel/movie_view_model.dart';
import '../../../modules/movies/views/movie_detail_view.dart';
import '../../../modules/movies/views/movie_list_view.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.movieListView:
        return normalNavigate(
            const MovieListView(), NavigationConstants.movieListView);

      case NavigationConstants.movieDetailView:
        if (args.arguments is MovieViewModel) {
          return normalNavigate(
              MovieDetailView(movieViewModel: args.arguments as MovieViewModel),
              NavigationConstants.movieDetailView);
        }
        throw NavigateException<MovieViewModel>(args.arguments);

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigation(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
        builder: (context) => widget, settings: RouteSettings(name: pageName));
  }
}
