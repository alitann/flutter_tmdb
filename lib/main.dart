import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/application_constants.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/lifecycle/application_life_cycle_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'modules/movies/bloc/movies_bloc.dart';
import 'modules/movies/services/api_service.dart';
import 'modules/movies/viewmodel/movie_list_view_model.dart';
import 'modules/movies/views/movie_list_view.dart';
import 'style/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: [...LanguageManager.instance.supportedLocales],
      path: ApplicationConstants
          .languageAssetPath, // <-- change the path of the Stranslatin files
      fallbackLocale: const Locale('en', 'US'),
      child: const MovieApp()));
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationLifeCycleManager(
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
        title: 'Movie App',
        theme: ThemeData(primarySwatch: ColorConstants.primarySwatchColor),
        home: BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(
              movieListViewModel: MovieListViewModel(ApiService(Dio())))
            ..add(FirstMoviesEvent()),
          child: const MovieListView(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
