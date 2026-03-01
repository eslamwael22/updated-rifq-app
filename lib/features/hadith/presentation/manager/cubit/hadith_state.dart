part of 'hadith_cubit.dart';

sealed class HadithState extends Equatable {
  const HadithState();

  @override
  List<Object> get props => [];
}

final class HadithInitial extends HadithState {}

final class HadithLoading extends HadithState {}

final class HadithSuccess extends HadithState {
  final List<HadithModel> hadithList;
  const HadithSuccess(this.hadithList);

  @override
  List<Object> get props => [hadithList];
}

final class HadithFailure extends HadithState {
  final String errorMessage;
  const HadithFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
