import 'package:flutter_test/flutter_test.dart';
import 'package:movie_list/features/movies/data/models/movie_data.dart';

import '../../../../fixtures/fixture.dart';

void main() {

  group('decoding spirited away', () {
    final data = MovieData.fromJson(fixtureJson("movie-spirited-away.json"));

    test('should have correct id', () {
      expect(data.id, 129);
    });
    test('should have correct title', () {
      expect(data.title, 'Spirited Away');
    });
    test('should have correct poster_path', () {
      expect(data.poster_path, '/ynXoOxmDHNQ4UAy0oU6avW71HVW.jpg');
    });
    test('should have correct vote_average', () {
      expect(data.vote_average, 8.15);
    });
  });
}
