import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> get popularMovies;
}
