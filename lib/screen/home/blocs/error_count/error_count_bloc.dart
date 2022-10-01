
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'error_count_event.dart';
part 'error_count_state.dart';

class ErrorCountBloc extends Bloc<ErrorCountEvent, ErrorCountState> {
  ErrorCountBloc() : super(ErrorCountState.initial()) {
    on<ErrorCountEvent>((event, emit) {
      if (state.errorCount == 2) {
        emit(state.copyWith(errorCount: state.errorCount + 1));
      }
    });
  }
}
