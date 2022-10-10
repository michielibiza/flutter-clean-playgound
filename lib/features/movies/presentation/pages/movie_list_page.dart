import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/features/movies/presentation/app_colors.dart';
import 'package:movie_list/features/movies/presentation/store/movie_list.dart';

import '../../domain/entities/movie.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final state = MovieList();

  @override
  void initState() {
    super.initState();
    state.update();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MovieList'),
          primary: true,
        ),
        body: Observer(
            builder: (_) => ListView.separated(
                  itemCount: state.movies.length,
                  itemBuilder: (_, index) => _buildListItem(state.movies[index]),
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                  ),
                )
        ),
      );

  Widget _buildListItem(Movie movie) {
    const padding = SizedBox(width: 16,);
    return SizedBox(
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
              image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(movie.posterUrl),
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
    );
  }
}
