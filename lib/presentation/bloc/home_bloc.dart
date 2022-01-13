import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_flutter/core/base/base_bloc.dart';
import 'package:music_player_flutter/core/base/event_bloc.dart';
import 'package:music_player_flutter/core/base/state_bloc.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:music_player_flutter/core/usecase/usecase.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/domain/usecase/get_initial_songs.dart';
import 'package:music_player_flutter/domain/usecase/search_songs.dart';
part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  GetInitialSongs getInitialSongs = GetInitialSongs.instance();
  SearchSongs searchSongs = SearchSongs.instance();

  HomeBloc() : super(InitialHomeState()) {
    on<GetInitialSongsEvent>((event, emit) async {
      emit(LoadingInitialSong());
      final songRes = await getInitialSongs(NoParams());
      songRes.fold((Failure l) {}, (r) {
        emit(SuccessGetInitialSong(r));
      });

      on<SearchSongsEvent>((event, emit) async {
        emit(LoadingSearch());
        final result = await searchSongs(SearchParams(term: event.terms));
        result.fold((l) {}, (r) {
          emit(SuccessSearch(r));
        });
      });
    });
  }
}
