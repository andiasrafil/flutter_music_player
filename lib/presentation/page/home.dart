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

  @override
  void initState() {
    pushEvent(GetInitialSongsEvent());
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    _player.onAudioPositionChanged.listen((d) {
      print("audio position length $d");
      setState(() {
        position = d;
      });
    });
    _player.onDurationChanged.listen((d) {
      setState(() {
        musicLength = d;
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

  @override
  Widget body(BuildContext context) {
    // TODO: implement body
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
                }
              },
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    height: 50,
                    width: 50,
                    child: const Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: songs.length,
                      itemBuilder: (BuildContext context, position) {
                        final data = songs[position];
                        return SongItemWidget(
                            imageUrl: data.artworkUrl!,
                            title: data.trackName!,
                            artist: data.artistName!,
                            isPlaying: songPlayed == data.artistId!,
                            onTapped: () {
                              play(data.trackUrl!, data.artistId!,
                                  data.trackName!, data.artistName!);
                            });
                      })
                ],
              )),
          PlayerBottomSheet(
              songName: songName,
              artistName: artistName,
              isShowing: songPlayed != 0,
              totalDuration: musicLength,
              currentDuration: position)
        ],
      ),
    );
  }
}
