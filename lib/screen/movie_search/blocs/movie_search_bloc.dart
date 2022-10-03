import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/model/custom_error.dart';
import 'package:flutter_movie_list/model/movie.dart';
import 'package:flutter_movie_list/model/movie_list.dart';
import 'package:flutter_movie_list/repository/movie_repository.dart';
import 'package:flutter_movie_list/screen/home/blocs/movie_list_status.dart';
import 'package:rxdart/rxdart.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final MovieRepository movieRepository;

  MovieSearchBloc({
    required this.movieRepository,
  }) : super(MovieSearchState.initial()) {
    on<SearchMovieListEvent>(_getSearchMovieList, transformer: debounce(const Duration(milliseconds: 1000)));
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(Duration duration) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _getSearchMovieList(
    SearchMovieListEvent event,
    Emitter<MovieSearchState> emit,
  ) async {
    emit(state.copyWith(status: MovieListStatus.loading));
    try {
      String? errorMsg;
      final MovieList movieList = await movieRepository.searchMovie(event.search).onError((error, stackTrace) {
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
