import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/ui/notes_display/video_display_notes_event.dart';
import 'package:vahak/ui/notes_display/video_display_notes_state.dart';

class VideoDisplayNotesBloc
    extends Bloc<VideoDisplayNotesEvent, VideoDisplayNotesState> {
  VideoDisplayNotesBloc() : super(DisplayNoNoteState());

  @override
  Stream<VideoDisplayNotesState> mapEventToState(
      VideoDisplayNotesEvent event) async* {
    if (event is NoteDisplayNoteEvent) {
      yield NotesDisplayState(event.notes);
    } else if (event is NoteDisplayNoNoteEvent) {
      yield DisplayNoNoteState();
    }
  }
}
