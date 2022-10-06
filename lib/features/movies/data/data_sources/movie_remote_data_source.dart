import 'package:movie_list/features/movies/data/models/movie_data.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieData>> get popularMovies ;
}
