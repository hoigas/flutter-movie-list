part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {}

class GetMovieEvent extends MovieDetailEvent {
  final int id;

  GetMovieEvent({
    required this.id,
  });
}
