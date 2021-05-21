import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/application/application_bloc.dart';
import 'package:vahak/route/rtn_routes.dart';
import 'package:vahak/ui/notes/video_notes_bloc.dart';
import 'package:vahak/ui/notes/video_notes_event.dart';
import 'package:vahak/ui/notes_display/video_display_notes_bloc.dart';
import 'package:vahak/ui/notes_display/video_display_notes_event.dart';
import 'package:vahak/ui/video_screen/video_screen_event.dart';
import 'package:vahak/ui/video_screen/video_screen_state.dart';
import 'package:video_player/video_player.dart';

class VideoScreenBloc extends Bloc<VideoScreenEvent, VideoScreenBlocState> {
  VideoScreenBloc(this.data) : super(VideoLoadingState());

  VideoPlayerController _controller;

  final Map<String, dynamic> data;

  final _formKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();

  /// scaffold which is used for toast or context
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  VideoPlayerController get videoPlayerController => _controller;

  @override
  Stream<VideoScreenBlocState> mapEventToState(VideoScreenEvent event) async* {
    if (event is VideoLoadingEvent) {
      debugPrint('video loading state');
      videoIntialization();
      yield VideoLoadingState();
    } else if (event is VideoLoadingSuccessfulEvent) {
      yield VideoLoadingSuccessfulState();
    } else if (event is VideoLoadingErrorEvent) {
      yield VideoLoadingErrorState();
    }
  }

  @override
  Future<Function> close() {
    super.close();
    _controller.dispose();
  }

  VideoDisplayNotesBloc videoDisplayNotesBloc;

  void updateVideoDisplayBloc(VideoDisplayNotesBloc videoDisplayNotesBloc) {
    if (VideoDisplayNotesBloc != null) {
      this.videoDisplayNotesBloc = videoDisplayNotesBloc;
    }
  }

  void videoIntialization() {
    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        this.add(VideoLoadingSuccessfulEvent());
        _controller.play();
      })
      ..addListener(() {
        debugPrint(
            'current --- time ${(_controller.value.position.inSeconds)}');
        if (data?.containsKey('notes') && data['notes'] != null) {
          Map<String, dynamic> notes = data['notes'];

          if (notes
              .containsKey(_controller.value.position.inSeconds.toString())) {
            if (_controller.value.isPlaying) {
              _controller.pause();
              videoDisplayNotesBloc.add(NoteDisplayNoteEvent(
                  notes[_controller.value.position.inSeconds.toString()]));
            }
          }
        }
        if (_controller.value.position.inSeconds ==
            _controller.value.duration.inSeconds) {
          List<dynamic> questions = data['quiz']['questions'];
          debugPrint('total question  --- ${questions.length}');
          if (data['quiz']['last_answered'] < questions.length - 1) {
            Navigator.pushNamed(
                scaffoldKey.currentContext, VahakRoutes.quizScreen,
                arguments: data['quiz']);
          } else {
            Navigator.pushNamed(
                scaffoldKey.currentContext, VahakRoutes.overAllQuizResultScreen,
                arguments: data['quiz']);
          }
        }
      });
  }

  void onClickOfAddNote(
      ApplicationBloc applicationBloc, VideoNotesBloc videoNotesBloc) {
    videoPlayerController.pause();

    // show the dialog
    showDialog(
      context: scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Note"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: noteController,
                  maxLines: 5,
                  enableSuggestions: false,
                  validator: (data) {
                    if (data == null || data.isEmpty) {
                      return 'Please enter note';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange)),
                    hintText: 'Note',
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  ),
                  onSaved: (email) {},
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Add"),
              onPressed: () {
                addNote(videoNotesBloc, context);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    ).then((value) {
      noteController.clear();
      if (!_controller.value.isPlaying) {
        _controller.play();
      }
    });
    /*showModalBottomSheet(
        context: scaffoldKey.currentContext,
        builder: (context) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: noteController,
                    maxLines: 5,
                    enableSuggestions: false,
                    validator: (data) {
                      if (data == null || data.isEmpty) {
                        return 'Please enter note';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange)),
                      hintText: 'Note',
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    ),
                    onSaved: (email) {},
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      addNote(videoNotesBloc, context);
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        }).then((value) {
      noteController.clear();
      if (!_controller.value.isPlaying) {
        _controller.play();
      }
    });*/
  }

  void addNote(VideoNotesBloc videoNotesBloc, BuildContext context) {
   if(_formKey.currentState.validate()){
     Map<String, dynamic> notes = {};
     String position;
     if (data['notes'] != null) {
       notes = data['notes'];
       position = (_controller.value.position.inSeconds - 1).toString();
       notes['${position.toString()}'] = noteController.text.trim();
     } else {
       position = (_controller.value.position.inSeconds - 1).toString();
       notes['${position.toString()}'] = noteController.text.trim();
     }
     data['notes'] = notes;
     noteController.clear();
     videoNotesBloc.add(NoteEvent(notes));
     Navigator.pop(context);
   }
  }

  void onDismissNoteDisplay(VideoDisplayNotesBloc videoDisplayNotesBloc) {
    videoDisplayNotesBloc.add(NoteDisplayNoNoteEvent());
    _controller
        .seekTo(Duration(seconds: _controller.value.position.inSeconds + 4));
    _controller.play();
  }
}
