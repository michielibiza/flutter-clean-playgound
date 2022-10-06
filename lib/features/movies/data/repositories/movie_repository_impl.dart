import 'package:movie_list/features/movies/domain/entities/movie.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';
import '../data_sources/movie_remote_data_source.dart';
import '../models/movie_data.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRemoteDataSource remoteSource;

  MovieRepositoryImpl(this.remoteSource);

  @override
  Future<List<Movie>> get popularMovies {
    return remoteSource.popularMovies
        .then((dataList) => dataList.map((e) => e.toDomain()).toList());
  }
}
