part of 'reciter_downloading_cubit.dart';

sealed class ReciterDownloadingState extends Equatable {
  const ReciterDownloadingState();

  @override
  List<Object> get props => [];
}

final class ReciterDownloadingInitial extends ReciterDownloadingState {}

final class ReciterFailure extends ReciterDownloadingState {
  final String errorMessage;
  const ReciterFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class ReciterDownloadingUpdated extends ReciterDownloadingState {
  final List<DownloadTask> tasks;
  const ReciterDownloadingUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];
}
