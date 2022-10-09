import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_list/features/movies/presentation/store/movie_list.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  final state = MovieList();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('MovieList'),
        ),
        body: Observer(
            builder: (_) => ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (_, index) => SizedBox(
                    height: 56,
                    child: Center(child: Text(state.movies[index].title)),
                  ),
                )),
        floatingActionButton: FloatingActionButton(
          onPressed: state.update,
          tooltip: 'Fetch',
          child: const Icon(Icons.add),
        ),
      );
}
