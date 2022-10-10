import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_list/features/movies/data/models/movie_list_data.dart';

import '../../../../fixtures/fixture.dart';
import 'movie_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  final mockClient = MockClient();
  when(mockClient.get(any, headers: anyNamed('headers')))
      .thenAnswer((_) async => http.Response(fixture('movie-page-1.json'), 200));

  final dataSource = MovieRemoteDataSourceImpl(client: mockClient);
  final result = await dataSource.popularMovies;

  test('data source is success', () async {
    expect(result is Success, true);
  });
  test('data source returns 20 results', () async {
    expect((result as Success<MovieListPageData>).data.results.length, 20);
  });
  test('data source first result is shawshank redemption', () async {
    expect((result as Success<MovieListPageData>).data.results[0].title, "The Shawshank Redemption");
  });
}
