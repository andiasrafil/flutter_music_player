import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/domain/usecase/search_songs.dart';

abstract class HomeRepository {
  Future<Either<Failure, Result>> getInitialSongs();
  Future<Either<Failure, Result>> searchSongs(SearchParams param);
}
