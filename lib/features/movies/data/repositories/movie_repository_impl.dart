import 'package:get_it/get_it.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/domain/entities/movie.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';

import '../data_sources/movie_remote_data_source.dart';
import '../models/movie_data.dart';

class MovieRepositoryImpl implements MovieRepository {
  late final MovieRemoteDataSource remoteSource;

  MovieRepositoryImpl({MovieRemoteDataSource? remoteSource}) {
    this.remoteSource = remoteSource ?? GetIt.instance.get<MovieRemoteDataSource>();
  }

  @override
  Future<Result<List<Movie>>> get popularMovies {
    // TODO add paging
    return remoteSource.popularMovies
        .then((result) =>
          result.map((page) =>
              page.results.map((e) => e.toDomain()).toList()
          )
    );
  }
}
