import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/data/models/movie_list_data.dart';

abstract class MovieRemoteDataSource {
  // TODO add paging
  Future<Result<MovieListPageData>> get popularMovies;
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  // TODO the key should come from some config object
  static const String popularMoviesUrl =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=07095d96b6edb4c082c0a9c45782c3ab&language=en-US&page=1";

  late final http.Client client;

  MovieRemoteDataSourceImpl({http.Client? client}) {
    this.client = client ?? GetIt.instance.get<http.Client>();
  }

  @override
  Future<Result<MovieListPageData>> get popularMovies async {
    try {
      final response = await client.get(Uri.parse(popularMoviesUrl));
      if (response.statusCode == 200) {
        return Success(MovieListPageData.fromJson(json.decode(response.body)));
      } else {
        return HttpError(response.statusCode);
      }
    } catch(e) {
      return Error(e);
    }
  }
}
