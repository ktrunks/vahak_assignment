import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/ui/notes/video_notes_event.dart';
import 'package:vahak/ui/notes/video_notes_state.dart';

class VideoNotesBloc extends Bloc<VideoNotesEvent, VideoNotesState> {
  VideoNotesBloc() : super(DefaultNoteState());

  @override
  Stream<VideoNotesState> mapEventToState(VideoNotesEvent event) async* {
    if (event is NoteEvent) {
      yield NotesState(event.notes);
    }
  }
}
