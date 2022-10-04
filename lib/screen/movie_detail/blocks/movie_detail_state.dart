part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieListStatus status;

  final Movie movie;
  final CustomError error;

  const MovieDetailState({
    required this.status,
    required this.movie,
    required this.error,
  });

  factory MovieDetailState.initial() {
    return MovieDetailState(
      status: MovieListStatus.initial,
      movie: Movie(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, movie, error];

  @override
  String toString() {
    return 'MovieDetailState{status: $status, movie: $movie, error: $error}';
  }

  MovieDetailState copyWith({
    MovieListStatus? status,
    Movie? movie,
    CustomError? error,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      error: error ?? this.error,
    );
  }
}
