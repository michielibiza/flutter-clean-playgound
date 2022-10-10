import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_list/features/core/result.dart';
import 'package:movie_list/features/movies/domain/repositories/movie_repository.dart';

import '../../domain/entities/movie.dart';

part 'movie_list.g.dart';

class MovieList = MovieListBase with _$MovieList;

abstract class MovieListBase with Store {
  final _repository = GetIt.instance.get<MovieRepository>();

  @readonly
  ObservableList<Movie> _movies = ObservableList.of([]);

  @observable
  bool hasError = false;

  @action
  Future<void> update() async {
    final result = await _repository.popularMovies;
    if (result is Success) {
      hasError = false;
      _movies = ObservableList.of((result as Success).data);
    } else {
      hasError = true;
    }
  }
}
