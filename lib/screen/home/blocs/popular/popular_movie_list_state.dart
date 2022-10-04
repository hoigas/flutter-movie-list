part of 'popular_movie_list_bloc.dart';

class PopularMovieListState extends Equatable {
  final MovieListStatus status;

  final List<Movie> movies;
  final CustomError error;

  const PopularMovieListState({
    required this.status,
    required this.movies,
    required this.error,
  });

  factory PopularMovieListState.initial() {
    return PopularMovieListState(
      status: MovieListStatus.initial,
      movies: const <Movie>[],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, movies, error];

  @override
  String toString() {
    return 'PopularMovieListState{status: $status, movies: $movies, error: $error}';
  }

  PopularMovieListState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    CustomError? error,
  }) {
    return PopularMovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
