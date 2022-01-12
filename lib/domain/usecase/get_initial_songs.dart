import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:music_player_flutter/core/usecase/usecase.dart';
import 'package:music_player_flutter/data/repositories/home_repository_impl.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/domain/repositories/home_repositories.dart';

class GetInitialSongs extends UseCase<Result, NoParams> {
  late HomeRepository repository;
  GetInitialSongs.instance() {
    repository = HomeRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Result>> call(NoParams param) async {
    return await repository.getInitialSongs();
  }
}
