import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:moviedb/app_constants.dart';
import 'package:moviedb/movie/pages/movie_page.dart';
import 'package:moviedb/movie/providers/movie_get_discover_provider.dart';
import 'package:moviedb/movie/repositories/movie_repository.dart';
import 'package:moviedb/movie/repositories/movie_repository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.api_key},
  );
  final Dio dio = Dio(dioOptions);

  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(MyApp(movieRepository: movieRepository));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MoviePage(),
      ),
    );
  }
}
