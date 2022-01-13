part of 'home_bloc.dart';

abstract class HomeEvent extends EventBloc {
  @override
  List<Object?> get props => [];
}

class GetInitialSongsEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SearchSongsEvent extends HomeEvent {
  final String terms;
  SearchSongsEvent({required this.terms});
}
