import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player_flutter/injection.dart';
import 'package:music_player_flutter/presentation/bloc/home_bloc.dart';

import 'mock_home_repository.dart';

void main() {
  group('bloc test', () {
    late HomeBloc homeBloc;
    late MockHomeRepository mockHomeRepository;
    setUp(() {
      EquatableConfig.stringify = true;
      mockHomeRepository = MockHomeRepository();
      homeBloc = HomeBloc(mockHomeRepository);
    });

    blocTest<HomeBloc, HomeState>("get initial songs",
        build: () => homeBloc,
        act: (bloc) => bloc.add(GetInitialSongsEvent()),
        wait: const Duration(seconds: 2),
        expect: () =>
            [LoadingInitialSong(), SuccessGetInitialSong(mockResult)]);

    blocTest<HomeBloc, HomeState>("search songs", 
    build: () => homeBloc, 
    act: (bloc) => bloc.add(SearchSongsEvent(terms: "andi")),
    wait: const Duration(seconds: 2),
    expect: () => [LoadingSearch(), SuccessSearch(mockResult)]
    );

    tearDown(() {
      homeBloc.close();
    });
  });
}
