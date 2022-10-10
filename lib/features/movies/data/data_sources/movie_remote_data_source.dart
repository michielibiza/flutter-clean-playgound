import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_list/features/movies/data/models/movie_list_data.dart';

abstract class MovieRemoteDataSource {
  // TODO add paging
  Future<MovieListPageData> get popularMovies;
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  // TODO the key should come from some config object
  static const String popularMoviesUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=07095d96b6edb4c082c0a9c45782c3ab&language=en-US&page=1";

  final http.Client client;

  MovieRemoteDataSourceImpl(this.client);

  @override
  Future<MovieListPageData> get popularMovies async {
    final response = await client.get(Uri.parse(popularMoviesUrl));
    if (response.statusCode == 200) {
      return MovieListPageData.fromJson(json.decode(response.body));
    } else {
      throw HttpException("returned error ${response.statusCode}");
    }
  }
}
