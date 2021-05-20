import 'package:equatable/equatable.dart';

abstract class VideoScreenBlocState extends Equatable {
  String get notes => null;
}

class VideoLoadingState extends VideoScreenBlocState {
  @override
  List<Object> get props => [];
}

class VideoLoadingSuccessfulState extends VideoScreenBlocState {
  @override
  List<Object> get props => [];
}

class VideoLoadingErrorState extends VideoScreenBlocState {
  @override
  List<Object> get props => [];
}
