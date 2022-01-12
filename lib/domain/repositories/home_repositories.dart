import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';

abstract class HomeRepository {
  Future<Either<Failure, Result>> getInitialSongs();
}
