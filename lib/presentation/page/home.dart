import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_flutter/core/base/stateful_bloc.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/presentation/bloc/home_bloc.dart';
import 'package:music_player_flutter/widget/player_bottom_sheet.dart';
import 'package:music_player_flutter/widget/song_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends StatefulBloc<HomePage, HomeBloc, HomeState, HomeEvent> {
  int songPlayed = 0;
  late AudioPlayer _player;
  late AudioCache cache;
  Duration position = new Duration();
  Duration musicLength = new Duration();
  List<Song> songs = [];
  String artistName = "";
  String songName = "";
  String searchTerms = "";
  bool isPlaying = false;
  PlayerState playerState = PlayerState.COMPLETED;

  @override
  void initState() {
    pushEvent(GetInitialSongsEvent());
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.onPlayerStateChanged.listen((PlayerState event) {
      setState(() {
        playerState = event;
      });
    });
    super.initState();
  }

  play(String url, int trackId, String song, String artis) async {
    int result = await _player.play(url);
    if (result == 1) {
      setState(() {
        songPlayed = trackId;
        songName = song;
        artistName = artis;
      });
    }
  }

  pause() {
    _player.pause();
  }

  resume() {
    _player.resume();
  }

  @override
  Widget body(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          blocListener(
              listener: (BuildContext context, state) {
                if (state is LoadingInitialSong) {
                } else if (state is SuccessGetInitialSong) {
                  setState(() {
                    songs = state.result.results!;
                  });
                } else if (state is SuccessSearch) {
                  setState(() {
                    songs = state.result.results!;
                  });
                }
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onEditingComplete: () {
                        if (searchTerms.isNotEmpty) {
                          closeKeyboard();
                          pushEvent(SearchSongsEvent(terms: searchTerms));
                        }
                      },
                      onChanged: (value) => setState(() => searchTerms = value),
                      decoration: const InputDecoration(
                          labelText: "Search song",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        itemCount: songs.length,
                        itemBuilder: (BuildContext context, position) {
                          final data = songs[position];
                          return SongItemWidget(
                              imageUrl: data.artworkUrl!,
                              title: data.trackName!,
                              artist: data.artistName!,
                              isPlaying: (songPlayed == data.artistId!) &&
                                  (playerState == PlayerState.PLAYING),
                              onTapped: () {
                                if (songPlayed != data.artistId) {
                                  play(data.trackUrl!, data.artistId!,
                                      data.trackName!, data.artistName!);
                                } else if (playerState ==
                                    PlayerState.COMPLETED) {
                                  play(data.trackUrl!, data.artistId!,
                                      data.trackName!, data.artistName!);
                                } else if (playerState == PlayerState.PAUSED) {
                                  resume();
                                } else if (playerState == PlayerState.PLAYING) {
                                  pause();
                                }
                              },
                              isSelected: songPlayed == data.artistId!);
                        }),
                  ),
                ],
              )),
          PlayerBottomSheet(
            songName: songName,
            artistName: artistName,
            isShowing: songPlayed != 0,
            isPlaying: playerState == PlayerState.PLAYING,
            onButtonPressed: () {
              if (playerState == PlayerState.PLAYING) {
                pause();
              } else {
                resume();
              }
            },
          )
        ],
      ),
    );
  }
}
