abstract class VideoDisplayNotesEvent {}

class NoteDisplayNoteEvent extends VideoDisplayNotesEvent {
  final String notes;

  NoteDisplayNoteEvent(this.notes);

}

class NoteDisplayNoNoteEvent extends VideoDisplayNotesEvent {
  NoteDisplayNoNoteEvent();
}
