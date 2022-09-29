import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_list.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MovieList {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MovieList({
    this.page = 0,
    List<Movie>? results,
    this.totalPages = 0,
    this.totalResults = 0,
  }) : results = results ?? [];

  factory MovieList.fromJson(Map<String, dynamic> json) => _$MovieListFromJson(json);

  @override
  String toString() {
    return 'MovieList{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}
