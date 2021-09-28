import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tmdb/modules/movies/views/movie_list_view.dart';

import 'core/constants/application_constants.dart';
import 'core/init/language/language_manager.dart';
import 'modules/movies/bloc/movies_bloc.dart';
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
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Movie App',
      theme: ThemeData(primarySwatch: ColorConstants.primarySwatchColor),
      home: BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc()..add(FirstMoviesEvent()),
          child: const MovieListView()),
      debugShowCheckedModeBanner: false,
    );
  }
}
