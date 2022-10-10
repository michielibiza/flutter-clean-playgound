// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_list/features/movies/domain/entities/movie.dart';

part 'movie_data.freezed.dart';
part 'movie_data.g.dart';

@freezed
class MovieData with _$MovieData {
  const factory MovieData({
    required int id,
    required String title,
    required String poster_path,
    required double vote_average,
    required String overview,
  }) = _MovieData;

  factory MovieData.fromJson(Map<String, Object?> json) => _$MovieDataFromJson(json);
}

extension Conversion on MovieData {
  // TODO setup configuration for base url and api key
  String _resolveIconImage(String path) => 'https://image.tmdb.org/t/p/w92$path?api_key=07095d96b6edb4c082c0a9c45782c3ab';
  String _resolveFullImage(String path) => 'https://image.tmdb.org/t/p/original$path?api_key=07095d96b6edb4c082c0a9c45782c3ab';

  Movie toDomain() => Movie(
      id, title, _resolveIconImage(poster_path), _resolveFullImage(poster_path), vote_average, overview);
}
