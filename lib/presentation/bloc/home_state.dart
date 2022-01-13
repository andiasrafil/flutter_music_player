part of 'home_bloc.dart';

abstract class HomeState extends StateBloc {
  @override
  List<Object?> get props => [];
}

class InitialHomeState extends HomeState {}

class LoadingInitialSong extends HomeState {}

class SuccessGetInitialSong extends HomeState {
  final Result result;
  SuccessGetInitialSong(this.result);
}

class LoadingSearch extends HomeState {}

class SuccessSearch extends HomeState {
  final Result result;
  SuccessSearch(this.result);
}
