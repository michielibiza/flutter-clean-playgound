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
  }) = _MovieData;

  factory MovieData.fromJson(Map<String, Object?> json) => _$MovieDataFromJson(json);
}

extension Conversion on MovieData {
  // TODO setup configuration for base url and api key
  Movie toDomain() => Movie(
      id, title, 'https://image.tmdb.org/t/p/w92$poster_path?api_key=07095d96b6edb4c082c0a9c45782c3ab', vote_average);
}
