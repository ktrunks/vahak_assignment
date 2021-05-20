import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/ui/home_screen.dart';
import 'package:vahak/ui/notes/video_notes_bloc.dart';
import 'package:vahak/ui/notes/video_notes_event.dart';
import 'package:vahak/ui/notes_display/video_display_notes_bloc.dart';
import 'package:vahak/ui/notes_display/video_display_notes_event.dart';
import 'package:vahak/ui/quiz/quiz_result_screen.dart';
import 'package:vahak/ui/quiz/quiz_screen.dart';
import 'package:vahak/ui/result/over_all_quiz_result.dart';
import 'package:vahak/ui/video_screen/video_screen.dart';
import 'package:vahak/ui/video_screen/video_screen_bloc.dart';
import 'package:vahak/ui/video_screen/video_screen_event.dart';

/// root application launch
final Handler rootHandler =
    Handler(handlerFunc: (context, params) => HomeScreen());

final Handler videoScreenHandler = Handler(handlerFunc: (context, params) {
  Map<String, dynamic> obj = ModalRoute.of(context).settings.arguments;
  Map<String, dynamic> notes =
      obj?.containsKey('notes') && obj['notes'] != null ? obj['notes'] : {};
  return MultiBlocProvider(
    providers: [
      BlocProvider<VideoScreenBloc>(
        create: (_) => VideoScreenBloc(obj)..add(VideoLoadingEvent()),
      ),
      BlocProvider<VideoNotesBloc>(
        create: (_) => VideoNotesBloc()..add(NoteEvent(notes)),
      ),
      BlocProvider<VideoDisplayNotesBloc>(
        create: (_) => VideoDisplayNotesBloc()..add(NoteDisplayNoNoteEvent()),
      ),
    ],
    child: VideoPlayerScreen(),
  );
});

final Handler quizScreenHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return QuizScreen(obj);
});

final Handler overAllQuizScreenHandler =
    Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return OverAllQuizResult(obj);
});

final Handler quizResultScreenHandler = Handler(handlerFunc: (context, params) {
  final obj = ModalRoute.of(context).settings.arguments;
  return QuizResultScreen(quiz: obj);
});
