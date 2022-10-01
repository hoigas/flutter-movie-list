import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/custom_error.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/model/movie_list.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/movie_list_status.dart';

part 'now_playing_movie_list_event.dart';

part 'now_playing_movie_list_state.dart';

class NowPlayingMovieListBloc extends Bloc<NowPlayingMovieListEvent, NowPlayingMovieListState> {
  final MovieRepository movieRepository;

  NowPlayingMovieListBloc({
    required this.movieRepository,
  }) : super(NowPlayingMovieListState.initial()) {
    on<GetNowPlayingMovieListEvent>(_getNowPlayingMovieList);
  }

  Future<void> _getNowPlayingMovieList(
    NowPlayingMovieListEvent event,
    Emitter<NowPlayingMovieListState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));
    try {
      String? errorMsg;
      final MovieList movieList = await movieRepository.getNowPlayingList().onError((error, stackTrace) {
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
