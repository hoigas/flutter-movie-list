part of 'upcoming_movie_list_bloc.dart';

class UpcomingMovieListState extends Equatable {
  final MovieListStatus status;

  final List<Movie> movies;
  final CustomError error;

  const UpcomingMovieListState({
    required this.status,
    required this.movies,
    required this.error,
  });

  factory UpcomingMovieListState.initial() {
    return UpcomingMovieListState(
      status: MovieListStatus.initial,
      movies: const <Movie>[],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, movies, error];

  @override
  String toString() {
    return 'UpcomingMovieListState{status: $status, movies: $movies, error: $error}';
  }

  UpcomingMovieListState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    CustomError? error,
  }) {
    return UpcomingMovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
