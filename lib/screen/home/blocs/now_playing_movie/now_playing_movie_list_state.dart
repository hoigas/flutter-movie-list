part of 'now_playing_movie_list_bloc.dart';

class NowPlayingMovieListState extends Equatable {
  final MovieListStatus status;

  final List<Movie> movies;
  final CustomError error;

  const NowPlayingMovieListState({
    required this.status,
    required this.movies,
    required this.error,
  });

  factory NowPlayingMovieListState.initial() {
    return NowPlayingMovieListState(
      status: MovieListStatus.initial,
      movies: const <Movie>[],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, movies, error];

  @override
  String toString() {
    return 'NowPlayingMovieListState{status: $status, movies: $movies, error: $error}';
  }

  NowPlayingMovieListState copyWith({
    MovieListStatus? status,
    List<Movie>? movies,
    CustomError? error,
  }) {
    return NowPlayingMovieListState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      error: error ?? this.error,
    );
  }
}
