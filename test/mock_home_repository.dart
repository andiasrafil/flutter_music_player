import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/domain/repositories/home_repositories.dart';
import 'package:music_player_flutter/domain/usecase/search_songs.dart';

const mockSongs = <Song>[
  Song(
      artistId: 1,
      artistName: "andi",
      artworkUrl: "facebook.com",
      trackName: "bernyanyi bersamaku",
      trackUrl: "instagram.com"),
  Song(
      artistId: 2,
      artistName: "asrafil",
      artworkUrl: "facebook.com",
      trackName: "bernyanyi bersamaku",
      trackUrl: "instagram.com"),
  Song(
      artistId: 3,
      artistName: "ardan",
      artworkUrl: "facebook.com",
      trackName: "bernyanyi bersamaku",
      trackUrl: "instagram.com"),
  Song(
      artistId: 4,
      artistName: "paliwang",
      artworkUrl: "facebook.com",
      trackName: "bernyanyi bersamaku",
      trackUrl: "instagram.com")
];
const mockResult = Result(resultCount: 4, results: mockSongs);

class MockHomeRepository implements HomeRepository {
  @override
  Future<Either<Failure, Result>> getInitialSongs() async {
    return Future.delayed(
        const Duration(seconds: 2), () => const Right(mockResult));
  }

  @override
  Future<Either<Failure, Result>> searchSongs(SearchParams param) async {
    return Future.delayed(
        const Duration(seconds: 2), () => const Right(mockResult));
  }
}
