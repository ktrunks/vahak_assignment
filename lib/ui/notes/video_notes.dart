import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoNotesWidget extends StatelessWidget {
  final Map<String, dynamic> notes;

  final VideoPlayerController videoPlayerController;

  VideoNotesWidget(this.notes, this.videoPlayerController);

  @override
  Widget build(BuildContext context) {
    debugPrint('notes--- ${notes}');
    List<Widget> notesWidget = [];
    if (notes != null && notes.length > 0) {
      notes.forEach((k, v) {
        print(
            ' width of  widget place --- ${int.parse(k) / videoPlayerController.value.duration.inSeconds * MediaQuery.of(context).size.width}');
        notesWidget.add(Padding(
          padding: EdgeInsets.only(
              left: int.parse(k) /
                  videoPlayerController.value.duration.inSeconds *
                  MediaQuery.of(context).size.width,
              bottom: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 5,
                height: 5,
                padding: EdgeInsets.only(
                    left: double.parse(k) * MediaQuery.of(context).size.width),
                color: Colors.green,
              ),
            ],
          ),
        ));
      });
    }
    return notesWidget.length > 0
        ? Stack(
            children: notesWidget,
          )
        : Container();
  }
}
