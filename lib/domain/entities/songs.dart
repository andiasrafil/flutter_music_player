import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final int? resultCount;
  final List<Song>? results;

  const Result({this.resultCount, this.results});

  @override
  List<Object?> get props => [resultCount, results];
}

class Song extends Equatable {
  final int? artistId;
  final String? artistName;
  final String? artworkUrl;
  final String? trackName;
  final String? trackUrl;
  final String? albumName;

  const Song({
    this.artistId,
    this.artistName,
    this.artworkUrl,
    this.trackName,
    this.trackUrl,
    this.albumName,
  });
  @override
  List<Object?> get props =>
      [artistId, artistId, artworkUrl, trackName, trackUrl, albumName];
}
