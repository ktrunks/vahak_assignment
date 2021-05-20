import 'package:equatable/equatable.dart';

abstract class VideoNotesEvent{}

class NoteEvent extends VideoNotesEvent {
  final Map<String, dynamic> notes;

  NoteEvent(this.notes);

  @override
  List<Object> get props => [notes];
}
