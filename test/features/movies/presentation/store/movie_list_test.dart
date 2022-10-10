import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/domain/entities/movie.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_list/features/movies/presentation/store/movie_list.dart';

import 'movie_list_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  MockMovieRepository createMock() {
    final mockRepository = MockMovieRepository();
    when(mockRepository.popularMovies).thenAnswer((_) async => Success([
      Movie(1, "aaa", "icon-url", "full-url", 1.11, "overview aaaaaaa"),
      Movie(2, "bbb", "icon-url", "full-url", 2.22, "overview bbbbbbb"),
    ]));
    return mockRepository;
  }

  group('before calling update', () {
    final mockRepository = createMock();
    final state = MovieList(repository: createMock());

    test('popularMovies is not called', () {
      verifyNever(mockRepository.popularMovies);
    });
    test("movies is empty", () {
      expect(state.movies.length, 0);
    });
    test("there is no error", () {
      expect(state.hasError, false);
    });
  });

  group('when calling update and there are movies', () {
    final mockRepository = createMock();
    final state = MovieList(repository: mockRepository);
    state.update();

    test('popularMovies is called', () {
      verify(mockRepository.popularMovies);
    });
    test('there are movies', () {
      expect(state.movies.length, 2);
    });
    test("there is no error", () {
      expect(state.hasError, false);
    });
  });

  group('when calling update and there is an error', () {
    final mockRepository = MockMovieRepository();
    when(mockRepository.popularMovies).thenAnswer((_) async => HttpError(404));
    final state = MovieList(repository: mockRepository);
    state.update();

    test("there is an error", () {
      expect(state.hasError, true);
    });
    test('there are no movies', () {
      expect(state.movies.length, 0);
    });
  });
}
