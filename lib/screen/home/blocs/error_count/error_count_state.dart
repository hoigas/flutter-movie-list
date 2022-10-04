part of 'error_count_bloc.dart';

class ErrorCountState extends Equatable {
  final int errorCount;

  ErrorCountState({
    required this.errorCount,
  });

  factory ErrorCountState.initial() {
    return ErrorCountState(errorCount: 0);
  }

  @override
  List<Object> get props => [errorCount];

  @override
  String toString() {
    return 'ErrorCountState{errorCount: $errorCount}';
  }

  ErrorCountState copyWith({
    int? errorCount,
  }) {
    return ErrorCountState(
      errorCount: errorCount ?? this.errorCount,
    );
  }
}
