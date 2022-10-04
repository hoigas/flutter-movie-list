import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/custom_error.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/model/movie_list.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/movie_list_status.dart';

part 'upcoming_movie_list_event.dart';

part 'upcoming_movie_list_state.dart';

class UpcomingMovieListBloc extends Bloc<UpcomingMovieListEvent, UpcomingMovieListState> {
  final MovieRepository movieRepository;

  UpcomingMovieListBloc({
    required this.movieRepository,
  }) : super(UpcomingMovieListState.initial()) {
    on<GetUpcomingMovieListEvent>(_getUpcomingMovieList);
  }

  Future<void> _getUpcomingMovieList(
    GetUpcomingMovieListEvent event,
    Emitter<UpcomingMovieListState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));
    try {
      String? errorMsg;

      final MovieList movieList = await movieRepository.getUpcomingList().onError((error, stackTrace) {
        errorMsg = error.toString();
        return MovieList();
      });

      if (errorMsg == null) {
        emit(state.copyWith(status: MovieListStatus.loaded, movies: movieList.results));
      } else {
        emit(state.copyWith(status: MovieListStatus.error, error: CustomError(errMsg: errorMsg!)));
      }
    } on CustomError catch (e) {
      emit(state.copyWith(status: MovieListStatus.error, error: e));
    }
  }
}
