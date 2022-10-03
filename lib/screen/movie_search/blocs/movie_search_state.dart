part of 'movie_search_bloc.dart';

class MovieSearchState {

  final MovieListStatus status;

  final List<Movie> movies;
  final CustomError error;

  const MovieSearchState({
    required this.status,
    required this.movies,
    required this.error,
  });

  factory MovieSearchState.initial() {
    return MovieSearchState(
      status: MovieListStatus.initial,
      movies: const <Movie>[],
      error: CustomError(),
    );
  }

  @override
  String toString() {
    return 'MovieSearchState{status: $status, movies: $movies, error: $error}';
  }

  @override
  List<Object> get props => [status, movies, error];

  MovieSearchState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    CustomError? error,
  }) {
    return MovieSearchState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
