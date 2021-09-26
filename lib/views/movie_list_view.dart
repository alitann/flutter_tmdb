import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/application_constants.dart';
import '../extensions/context_extension.dart';
import '../modules/movies/models/movie.dart';
import 'movie_detail_view.dart';

import '../modules/movies/bloc/movies_bloc.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  bool isSearchOpen = false;
  final TextEditingController filterContoller = TextEditingController();
  final FocusNode filterFocus = FocusNode();

  List<Movie> findMovies = [];
  List<Movie> firstMovies = [];

  final Widget _appBar = const Text('Movie viewer');

  @override
  Widget build(BuildContext context) {
    void openCloseSearchBar() {
      setState(() {
        isSearchOpen = !isSearchOpen;
        if (!isSearchOpen) {
          resetMovies(context);
          filterContoller.text = "";
        }
      });
    }

    TextField _appBarSearch = TextField(
        onChanged: (value) {
          resetMovies(context);

          if (firstMovies.isNotEmpty) {
            findMovies = firstMovies
                .where((element) => element.originalTitle
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                .toList();

            showFoundedMovies(context);
          }
        },
        style: const TextStyle(color: Colors.white),
        controller: filterContoller,
        autofocus: true,
        focusNode: filterFocus,
        decoration: const InputDecoration(
          fillColor: Colors.red,
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'Search Movie',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ));

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: !isSearchOpen ? _appBar : _appBarSearch,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: context.lowValue),
                child: isSearchOpen
                    ? IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => openCloseSearchBar())
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => openCloseSearchBar()),
              ),
            ],
          ),
          body: buildBody()),
    );
  }

  void showFoundedMovies(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context).searchedMovies = findMovies;
    BlocProvider.of<MoviesBloc>(context).add(SearchPageMoviesEvent());
  }

  void resetMovies(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context).searchedMovies = firstMovies;
    BlocProvider.of<MoviesBloc>(context).add(SearchPageMoviesEvent());
  }

  BlocBuilder<MoviesBloc, MoviesState> buildBody() {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      if (state is LoadingMoviesState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is LoadedMoviesState) {
        firstMovies = state.movies;
        return ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            Movie movie = state.movies[index];
            return buildMovieCard(movie, index, context);
          },
        );
      } else if (state is SearchedMoviesState) {
        return ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            Movie movie = state.movies[index];
            return buildMovieCard(movie, index, context);
          },
        );
      } else if (state is FailedMoviesState) {
        return Center(child: Text(state.errorMessage));
      }
      return const Center(child: Text('Nothing'));
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Movie viewer'),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.lowValue),
          child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ),
      ],
    );
  }

  Card buildMovieCard(Movie movie, int index, BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(
              ApplicationConstants.imageBaseUrl + movie.posterPath.toString()),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          movie.title.toString(),
        ),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetailView(
                        movie: movie,
                      )));
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Movie> recentSearchedData;
  final List<Movie> data;

  DataSearch({required this.recentSearchedData, required this.data});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, 'OK');
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('A');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Movie> suggestionList =
        query.isEmpty ? recentSearchedData : data;
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(suggestionList[index].title.toString()));
        });
  }
}
