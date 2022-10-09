import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';

import '../../domain/entities/movie.dart';

part 'movie_list.g.dart';

class MovieList = MovieListBase with _$MovieList;

abstract class MovieListBase with Store {
  final _repository = GetIt.instance.get<MovieRepository>();

  @readonly
  ObservableList<Movie> _movies = ObservableList.of([]);

  @action
  Future<void> update() async {
    _movies = ObservableList.of(await _repository.popularMovies);
  }
}
