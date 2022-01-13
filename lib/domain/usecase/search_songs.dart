import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:music_player_flutter/core/usecase/usecase.dart';
import 'package:music_player_flutter/data/repositories/home_repository_impl.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/domain/repositories/home_repositories.dart';

class SearchSongs extends UseCase<Result, SearchParams> {
  late HomeRepository repository;
  SearchSongs.instance() {
    repository = HomeRepositoryImpl.getInstance();
  }
  @override
  Future<Either<Failure, Result>> call(SearchParams param) async {
    return await repository.searchSongs(param);
  }
}

class SearchParams extends Equatable {
  String term;
  SearchParams({required this.term});

  Map<String, dynamic> toJson() {
    return {"term": term};
  }

  @override
  List<Object?> get props => [term];
}
