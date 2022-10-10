import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/domain/entities/movie.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_list/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'movie_list_page_test.mocks.dart';

@GenerateMocks([MovieRepository])
main() {
  final mockRepository = MockMovieRepository();
  const imageUrl = "https://image.tmdb.org/t/p/w92/cVn8E3Fxbi8HzYYtaSfsblYC4gl.jpg?api_key=07095d96b6edb4c082c0a9c45782c3ab";
  when(mockRepository.popularMovies).thenAnswer((_) async => Success([
    Movie(1, "aaa", imageUrl, imageUrl, 1.11, "overview aaaaaaa"),
    Movie(2, "bbb", imageUrl, imageUrl, 2.22, "overview bbbbbbb"),
  ]));

  GetIt.instance.registerSingleton<MovieRepository>(mockRepository);

  testWidgets('show "MovieList" in app bar', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    var appTitle = find.byKey(const Key("app-bar-title"));
    expect(appTitle, findsOneWidget);
    expect((tester.element(appTitle).widget as Text).data, "MovieList");
  });

  testWidgets('show movie title in list', (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      var movieTitle = find.byKey(const Key('list-item-title'));
      expect(movieTitle, findsNWidgets(2));
      expect((tester.element(movieTitle.first).widget as Text).data, "aaa");
    });
  });
}
