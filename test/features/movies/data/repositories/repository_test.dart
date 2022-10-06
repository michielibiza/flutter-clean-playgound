import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_list/features/movies/data/models/movie_data.dart';
import 'package:movie_list/features/movies/data/repositories/movie_repository_impl.dart';

import 'repository_test.mocks.dart';

@GenerateMocks([MovieRemoteDataSource])
void main() async {
  group('when dataSource.popularMovies has 2 items', () {
    final mockDataSource = MockMovieRemoteDataSource();
    when(mockDataSource.popularMovies).thenAnswer((_) async => [
          const MovieData(id: 1, title: "aaa", poster_path: "/aaa.png", vote_average: 1.11),
          const MovieData(id: 2, title: "bbb", poster_path: "/bbb.png", vote_average: 2.22),
        ]);

    final repository = MovieRepositoryImpl(mockDataSource);

    test('repository.popularMovies returns 2 movies', () async {
      final popularMovies = await repository.popularMovies;
      expect(popularMovies.length, 2);
    });
    test('repository.popularMovies preserves order', () async {
      final popularMovies = await repository.popularMovies;
      expect(popularMovies[0].id, 1);
      expect(popularMovies[1].id, 2);
    });
  });

  group('when dataSource.popularMovies has no items', () {
    final mockDataSource = MockMovieRemoteDataSource();
    when(mockDataSource.popularMovies).thenAnswer((_) async => []);

    final repository = MovieRepositoryImpl(mockDataSource);

    test('repository.popularMovies has no items', () async {
      final popularMovies = await repository.popularMovies;
      expect(popularMovies.length, 0);
    });
  });
}
