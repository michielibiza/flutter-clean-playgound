import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_list/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_list/features/movies/data/repositories/movie_repository_impl.dart';

import 'features/movies/domain/repositories/movie_repository.dart';
import 'package:http/http.dart' as http;

import 'features/movies/presentation/pages/movie_list_page.dart';

void main() {
  setupDi();
  runApp(const MyApp());
}

void setupDi() {
  final di = GetIt.instance;
  di.registerSingleton<http.Client>(http.Client());
  di.registerSingleton<MovieRemoteDataSource>(MovieRemoteDataSourceImpl());
  di.registerSingleton<MovieRepository>(MovieRepositoryImpl());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieList',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieListPage(),
    );
  }
}
