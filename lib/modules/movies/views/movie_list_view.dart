import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/navigation_constants.dart';
import '../../../core/init/language/locale_keys.g.dart';
import '../../../core/init/navigation/navigation_service.dart';
import '../../../extensions/context_extension.dart';
import '../bloc/movies_bloc.dart';
import '../models/movie.dart';
import '../viewmodel/movie_view_model.dart';

class MovieListView extends StatefulWidget {
  const MovieListView({Key? key}) : super(key: key);

  @override
  State<MovieListView> createState() => _MovieListViewState();
}

class _MovieListViewState extends State<MovieListView> {
  bool isSearchOpen = false;
  final TextEditingController filterContoller = TextEditingController();
  final FocusNode filterFocus = FocusNode();

  List<MovieViewModel> filteredMovies = [];
  List<MovieViewModel> movies = [];

  final Widget _appBar = const Text(LocaleKeys.title).tr();

  NavigationService navigation = NavigationService.instance;

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

    void incrementPageNumber() {
      BlocProvider.of<MoviesBloc>(context).add(IncreasePageMoviesEvent());
    }

    void decrementPageNumber() {
      BlocProvider.of<MoviesBloc>(context).add(DecreasePageMoviesEvent());
    }

    TextField _appBarSearch = TextField(
        onChanged: (value) {
          resetMovies(context);

          if (movies.isNotEmpty) {
            filterMovies(value);

            showFilteredMovies(context);
          }
        },
        style: const TextStyle(color: Colors.white),
        controller: filterContoller,
        autofocus: true,
        focusNode: filterFocus,
        decoration: const InputDecoration(
          fillColor: Colors.red,
          hintStyle: TextStyle(color: Colors.white),
          hintText: 'search...',
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
                    : buildAppBarActions(context, decrementPageNumber,
                        incrementPageNumber, openCloseSearchBar),
              ),
            ],
          ),
          body: buildBody()),
    );
  }

  Row buildAppBarActions(BuildContext context, Function() decrementPageNumber,
      Function() incrementPageNumber, Function() openCloseSearchBar) {
    return Row(
      children: [
        buildPageNumberText(),
        SizedBox(
          width: context.lowValue,
        ),
        IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => decrementPageNumber()),
        IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => incrementPageNumber()),
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => openCloseSearchBar()),
      ],
    );
  }

  void filterMovies(String value) {
    filteredMovies = movies
        .where((element) => element.movie.title
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
  }

  BlocBuilder<MoviesBloc, MoviesState> buildPageNumberText() {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      return Text(LocaleKeys.page.tr() +
          BlocProvider.of<MoviesBloc>(context).pageNumber.toString());
    });
  }

  void showFilteredMovies(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context).searchedMovies = filteredMovies;
    BlocProvider.of<MoviesBloc>(context).add(SearchPageMoviesEvent());
  }

  void resetMovies(BuildContext context) {
    BlocProvider.of<MoviesBloc>(context).searchedMovies = movies;
    BlocProvider.of<MoviesBloc>(context).add(SearchPageMoviesEvent());
  }

  BlocBuilder<MoviesBloc, MoviesState> buildBody() {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      if (state is LoadingMoviesState) {
        return handleLoadingMoviesState();
      } else if (state is LoadedMoviesState) {
        return handleLoadedMoviesState(state);
      } else if (state is SearchedMoviesState) {
        return handleSearchMoviesState(state);
      } else if (state is FailedMoviesState) {
        return handleFailedMoviesState(state);
      }
      return doNothing();
    });
  }

  Center doNothing() {
    return Center(child: const Text(LocaleKeys.info).tr());
  }

  Center handleFailedMoviesState(FailedMoviesState state) {
    return Center(child: Text(state.errorMessage));
  }

  ListView handleSearchMoviesState(SearchedMoviesState state) {
    return ListView.builder(
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        MovieViewModel movie = state.movies[index];
        return buildMovieCard(movie, index, context);
      },
    );
  }

  ListView handleLoadedMoviesState(LoadedMoviesState state) {
    movies = state.movies;
    return ListView.builder(
      itemCount: state.movies.length,
      itemBuilder: (context, index) {
        MovieViewModel movie = state.movies[index];
        return buildMovieCard(movie, index, context);
      },
    );
  }

  Center handleLoadingMoviesState() {
    return const Center(child: CircularProgressIndicator());
  }

  Card buildMovieCard(
      MovieViewModel movieViewModel, int index, BuildContext context) {
    return Card(
      child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: movieViewModel.posterImageUrl,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 20,
              backgroundImage: imageProvider,
            ),
          ),
          title: Text(
            movieViewModel.movie.title.toString(),
          ),
          trailing: const Icon(Icons.arrow_right),
          onTap: () => navigation.navigateToPage(
              path: NavigationConstants.movieDetailView, data: movieViewModel)),
    );
  }
}

//Different search approach, but we didn't use this delegate for this project.
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
