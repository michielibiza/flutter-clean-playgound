// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
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
  Movie toDomain() => Movie(id, title, poster_path, vote_average);
}
