import 'package:mobx/mobx.dart';

import '../../domain/entities/movie.dart';
import 'movie_list.dart';

part 'movie_navigation.g.dart';

class MovieNavigation = MovieNavigationBase with _$MovieNavigation;

abstract class MovieNavigationBase with Store {

  MovieList movieList = MovieList();

  @observable
  Movie? selectedMovie;

  @observable
  bool isSearching = false;

  @observable
  String query = '';

  @computed get hasBackButton => selectedMovie != null;

  @computed
  String get title {
    if (query.isNotEmpty) {
      return query;
    }

    return selectedMovie?.title ?? 'MovieList';
  }

  @action
  select(Movie selection) {
    selectedMovie = selection;
    cancelSearch();
  }

  @action
  back() {
    selectedMovie = null;
  }

  @action
  startSearch() {
    isSearching = true;
    query = '';
  }

  @action
  cancelSearch() {
    isSearching = false;
    query = '';
  }
}
