import 'package:music_player_flutter/domain/entities/songs.dart';

class ResultModel extends Result {
  final int? resultCount;
  final List<SongModel>? results;

  ResultModel({this.resultCount, this.results})
      : super(resultCount: resultCount, results: results);

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
        resultCount: json["resultCount"],
        results: List<SongModel>.from(
            json["results"].map((x) => SongModel.fromJson(x))));
  }
}

class SongModel extends Song {
  final int? artistId;
  final String? artistName;
  final String? artworkUrl;
  final String? trackName;
  final String? trackUrl;
  final String? albumName;

  const SongModel(
      {this.artistId,
      this.artistName,
      this.artworkUrl,
      this.trackName,
      this.trackUrl,
      this.albumName})
      : super(
            artistId: artistId,
            artistName: artistName,
            artworkUrl: artworkUrl,
            trackName: trackName,
            trackUrl: trackUrl,
            albumName: albumName);

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        artistId: json["trackId"],
        artistName: json["artistName"],
        artworkUrl: json["artworkUrl100"],
        trackName: json["trackName"],
        trackUrl: json["previewUrl"],
        albumName: json["collectionName"]);
  }
}
