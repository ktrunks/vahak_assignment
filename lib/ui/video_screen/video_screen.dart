import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/application/application_bloc.dart';
import 'package:vahak/ui/notes/video_notes.dart';
import 'package:vahak/ui/notes/video_notes_bloc.dart';
import 'package:vahak/ui/notes/video_notes_state.dart';
import 'package:vahak/ui/notes_display/video_display_notes.dart';
import 'package:vahak/ui/notes_display/video_display_notes_bloc.dart';
import 'package:vahak/ui/notes_display/video_display_notes_state.dart';
import 'package:vahak/ui/video_screen/video_screen_bloc.dart';
import 'package:vahak/ui/video_screen/video_screen_state.dart';
import 'package:vahak/widget/video_progress_bar.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen();

  @override
  State createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  VideoScreenBloc videoScreenBloc;
  VideoDisplayNotesBloc videoDisplayNotesBloc;
  VideoNotesBloc videoNotesBloc;

  @override
  Widget build(BuildContext context) {
    videoScreenBloc = BlocProvider.of<VideoScreenBloc>(context);
    videoDisplayNotesBloc = BlocProvider.of<VideoDisplayNotesBloc>(context);
    videoNotesBloc = BlocProvider.of<VideoNotesBloc>(context);

    final ApplicationBloc applicationBloc =
        BlocProvider.of<ApplicationBloc>(context);
    videoScreenBloc.updateVideoDisplayBloc(videoDisplayNotesBloc);
    return Scaffold(
      key: videoScreenBloc.scaffoldKey,
      body: Column(
        children: [
          BlocBuilder<VideoScreenBloc, VideoScreenBlocState>(
            builder: (context, state) {
              Widget videoWidget;
              if (state is VideoLoadingState) {
                videoWidget = Container(
                    height: 300,
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is VideoLoadingSuccessfulState) {
                videoWidget = Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: videoScreenBloc
                          .videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(videoScreenBloc.videoPlayerController),
                    ),
                    Positioned.fill(
                        child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              child: VideoProgressBar(
                                controlManager:
                                    videoScreenBloc.videoPlayerController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                    Positioned.fill(
                      child: Column(
                        children: [
                          BlocBuilder<VideoNotesBloc, VideoNotesState>(
                            builder: (context, state) {
                              Widget notesWidget;
                              if (state is NotesState) {
                                notesWidget = VideoNotesWidget(state.notes,
                                    videoScreenBloc.videoPlayerController);
                              } else {
                                notesWidget = Container();
                              }
                              return Row(
                                children: [
                                  Expanded(child: notesWidget),
                                ],
                              );
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    )
                  ],
                );
              } else if (state is VideoLoadingErrorState) {
                videoWidget = Container(
                    height: 300,
                    child: Center(
                        child: Text(
                      'error loading video',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    )));
              }
              return videoWidget;
            },
          ),
          BlocBuilder<VideoDisplayNotesBloc, VideoDisplayNotesState>(
            builder: (context, state) {
              Widget noteWidget;
              if (state is NotesDisplayState) {
                noteWidget = Container();
              } else if (state is DisplayNoNoteState) {
                noteWidget = ElevatedButton(
                    onPressed: () {
                      videoScreenBloc.onClickOfAddNote(
                          applicationBloc, videoNotesBloc);
                    },
                    child: Text('Add Note'));
              }
              return noteWidget;
            },
          ),
          BlocBuilder<VideoDisplayNotesBloc, VideoDisplayNotesState>(
            builder: (context, state) {
              Widget noteWidget;
              if (state is NotesDisplayState) {
                noteWidget =
                    VideoDisplayNotesWidget(state.notes, onClickOfDismiss);
              } else if (state is DisplayNoNoteState) {
                noteWidget = Container();
              }
              return noteWidget;
            },
          ),
        ],
      ),
    );
  }

  void onClickOfDismiss() {
    videoScreenBloc.onDismissNoteDisplay(videoDisplayNotesBloc);
  }
}
