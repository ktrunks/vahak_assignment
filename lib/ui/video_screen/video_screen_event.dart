import 'package:equatable/equatable.dart';

abstract class VideoScreenEvent extends Equatable {}

class VideoLoadingEvent extends VideoScreenEvent {
  @override
  List<Object> get props => [];
}

class VideoLoadingSuccessfulEvent extends VideoScreenEvent {
  @override
  List<Object> get props => [];
}

class VideoLoadingErrorEvent extends VideoScreenEvent {
  @override
  List<Object> get props => [];
}
