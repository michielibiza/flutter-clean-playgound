import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list/features/movies/data/models/movie_data.dart';

void main() {

  group('converting data to domain', () {
    const data = MovieData(id: 12, title: "the matrix", poster_path: "/poster.png", vote_average: 0.98);
    final entity = data.toDomain();

    test('should have correct id', () {
      expect(entity.id, 12);
    });
    test('should have correct title', () {
      expect(entity.title, 'the matrix');
    });
    test('should have correct posterUrl', () {
      expect(entity.posterUrl, '/poster.png');
    });
    test('should have correct score', () {
      expect(entity.score, 0.98);
    });
  });
}
