// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_data.dart';

part 'movie_list_data.freezed.dart';

part 'movie_list_data.g.dart';

@freezed
class MovieListPageData with _$MovieListPageData {
  const factory MovieListPageData({
    required int total_results,
    required int page,
    required int total_pages,
    required List<MovieData> results,
  }) = _MovieListPageData;

  factory MovieListPageData.fromJson(Map<String, Object?> json) => _$MovieListPageDataFromJson(json);
}
