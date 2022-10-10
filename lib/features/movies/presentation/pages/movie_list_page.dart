import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/features/movies/presentation/app_colors.dart';
import 'package:movie_list/features/movies/presentation/store/movie_list.dart';

import '../../domain/entities/movie.dart';
import '../store/movie_navigation.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final state = MovieNavigation();

  @override
  void initState() {
    super.initState();
    state.movieList.update();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: Observer(builder: (_) => state.hasBackButton
          ? BackButton(onPressed: state.back,)
          : const SizedBox(width: 0, height: 0,)
      ),
      title: Observer(builder: (_) => Text(state.title)),
      primary: true,
    ),
    body: Observer(
        builder: (_) {
          if (state.selectedMovie != null) {
            return _showDetails(state.selectedMovie!);
          }
          if (state.isSearching) {
            return const Center(child: Text("not implemented"));
          }
          return _showPopularMovies(state.movieList, (movie) => state.select(movie));
        }
    ),
  );

  Widget _showPopularMovies(MovieList state, Function(Movie) onTap) {
    return ListView.separated(
      itemCount: state.movies.length,
      itemBuilder: (_, index) => _buildListItem(state.movies[index], onTap),
      separatorBuilder: (_, __) => const Divider(
        height: 1,
      ),
    );
  }

  Widget _buildListItem(Movie movie, Function(Movie) onTap) {
    const padding = SizedBox(width: 16,);
    return GestureDetector(
        onTap: () => onTap(movie),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              padding,
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(movie.posterIconUrl),
                  ),
                ),
              ),
              padding,
              Expanded(
                child: Text(
                  movie.title,
                  style: const TextStyle(color: AppColors.primary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              padding,
              Image.asset('assets/next.png', width: 12, height: 12, color: AppColors.grey,),
              padding,
            ],
          ),
        ));
  }

  Widget _showDetails(Movie movie) =>
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.network(
                movie.posterFullUrl,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 40,),
              Text(
                movie.overview,
                style: const TextStyle(color: AppColors.primary),
              ),
            ],
          )
      );
}
