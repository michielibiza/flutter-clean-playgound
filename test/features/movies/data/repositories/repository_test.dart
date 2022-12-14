import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_list/features/movies/data/models/movie_data.dart';
import 'package:movie_list/features/movies/data/models/movie_list_data.dart';
import 'package:movie_list/features/movies/data/repositories/movie_repository_impl.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([MovieRemoteDataSource])
void main() async {
  group('when dataSource.popularMovies has 2 items', () {
    final mockDataSource = MockMovieRemoteDataSource();
    when(mockDataSource.popularMovies)
        .thenAnswer((_) async => Success(const MovieListPageData(total_results: 100, page: 1, total_pages: 5, results: [
              MovieData(id: 1, title: "aaa", poster_path: "/aaa.png", vote_average: 1.11, overview: "aaaaaaa"),
              MovieData(id: 2, title: "bbb", poster_path: "/bbb.png", vote_average: 2.22, overview: "bbbbbbb"),
            ])));
    final repository = MovieRepositoryImpl(remoteSource: mockDataSource);

    test('repository.popularMovies returns a success', () async {
      final result = await repository.popularMovies;
      expect(result is Success, true);
    });
    test('repository.popularMovies returns 2 movies', () async {
      final result = await repository.popularMovies;
      expect((result as Success).data.length, 2);
    });
    test('repository.popularMovies preserves order', () async {
      final result = await repository.popularMovies;
      expect((result as Success).data[0].id, 1);
      expect((result as Success).data[1].id, 2);
    });
  });

  group('when dataSource.popularMovies has no items', () {
    final mockDataSource = MockMovieRemoteDataSource();
    when(mockDataSource.popularMovies)
        .thenAnswer((_) async => Success(const MovieListPageData(total_results: 0, page: 0, total_pages: 0, results: [])));

    final repository = MovieRepositoryImpl(remoteSource: mockDataSource);

    test('repository.popularMovies has no items', () async {
      final result = await repository.popularMovies;
      expect((result as Success).data.length, 0);
    });
  });

  group('when dataSource produces error', () {
    final mockDataSource = MockMovieRemoteDataSource();
    when(mockDataSource.popularMovies)
        .thenAnswer((_) async => HttpError(404));

    final repository = MovieRepositoryImpl(remoteSource: mockDataSource);

    test('then repository produces error', () async {
      final result = await repository.popularMovies;
      expect(result is HttpError, true);
    });
  });
}
