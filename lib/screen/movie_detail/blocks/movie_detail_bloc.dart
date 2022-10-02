import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/custom_error.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/movie_list_status.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({
    required this.movieRepository,
  }) : super(MovieDetailState.initial()) {
    on<GetMovieEvent>(_getMovie);
  }

  Future<void> _getMovie(
    GetMovieEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));
    try {
      String? errorMsg;
      final Movie movie = await movieRepository.getMovieDetail(event.id).onError((error, stackTrace) {
        errorMsg = error.toString();
        return Movie();
      });

      if (errorMsg == null) {
        emit(state.copyWith(status: MovieListStatus.loaded, movie: movie));
      } else {
        emit(state.copyWith(status: MovieListStatus.error, error: CustomError(errMsg: errorMsg!)));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(status: MovieListStatus.error, error: e));
    }
  }
}
