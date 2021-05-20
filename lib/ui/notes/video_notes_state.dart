abstract class VideoNotesState {}

class NotesState extends VideoNotesState {
  final Map<String, dynamic> notes;

  NotesState(this.notes);
}

class DefaultNoteState extends VideoNotesState {}
