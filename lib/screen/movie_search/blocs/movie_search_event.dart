part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent {}

class SearchMovieListEvent extends MovieSearchEvent {
  final String search;

  SearchMovieListEvent({
    required this.search,
  });
}
