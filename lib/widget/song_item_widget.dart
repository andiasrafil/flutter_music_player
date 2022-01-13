import 'package:flutter/material.dart';

typedef OnSongTapped = void Function();

class SongItemWidget extends StatelessWidget {
  const SongItemWidget(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.artist,
      required this.albumName,
      required this.isPlaying,
      required this.onTapped,
      required this.isSelected})
      : super(key: key);

  final String imageUrl;
  final String title;
  final String artist;
  final String albumName;
  final bool isPlaying;
  final OnSongTapped onTapped;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapped(),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: isSelected ? Colors.blue[50] : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(48), // Image radius
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 3, style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(artist, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(albumName, style: const TextStyle(fontSize: 10))
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 1,
              child: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 50, color: Colors.blue[100]),
            )
          ],
        ),
      ),
    );
  }
}
