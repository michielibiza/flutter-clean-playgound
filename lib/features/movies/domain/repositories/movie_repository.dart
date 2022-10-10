import '../../../core/result.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Result<List<Movie>>> get popularMovies;
}
