import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list/features/movies/data/models/movie_data.dart';

void main() {

  group('converting data to domain', () {
    const data = MovieData(
        id: 12,
        title: "the matrix",
        poster_path: "/poster.png",
        vote_average: 0.98,
        overview: "neo something trinity something"
    );
    final entity = data.toDomain();

    test('should have correct id', () {
      expect(entity.id, 12);
    });
    test('should have correct title', () {
      expect(entity.title, 'the matrix');
    });
    test('should have correct icon posterUrl', () {
      expect(entity.posterIconUrl, 'https://image.tmdb.org/t/p/w92/poster.png?api_key=07095d96b6edb4c082c0a9c45782c3ab');
    });
    test('should have correct full posterUrl', () {
      expect(entity.posterFullUrl, 'https://image.tmdb.org/t/p/original/poster.png?api_key=07095d96b6edb4c082c0a9c45782c3ab');
    });
    test('should have correct score', () {
      expect(entity.score, 0.98);
    });
    test('should have correct overview', () {
      expect(entity.overview, "neo something trinity something");
    });
  });
}
