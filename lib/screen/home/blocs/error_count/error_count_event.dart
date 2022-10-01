part of 'error_count_bloc.dart';

abstract class ErrorCountEvent extends Equatable {
  const ErrorCountEvent();

  @override
  List<Object> get props => [];
}

class IncreaseErrorCountEvent extends ErrorCountEvent {}
