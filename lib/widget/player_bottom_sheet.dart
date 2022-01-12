import 'package:flutter/material.dart';

class PlayerBottomSheet extends StatelessWidget {
  const PlayerBottomSheet(
      {Key? key,
      required this.isShowing,
      required this.totalDuration,
      required this.currentDuration,
      required this.songName,
      required this.artistName})
      : super(key: key);
  final bool isShowing;
  final Duration totalDuration;
  final Duration currentDuration;
  final String songName;
  final String artistName;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width,
        height: isShowing ? 100 : 0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue[400]!, Colors.blue[200]!]),
            color: Colors.black,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.play_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(songName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18)),
                        Text(
                          artistName,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
