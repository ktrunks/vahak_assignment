abstract class VideoDisplayNotesState {}

class NotesDisplayState extends VideoDisplayNotesState {
  String notes;

  NotesDisplayState(this.notes);
}

class DisplayNoNoteState extends VideoDisplayNotesState {}
