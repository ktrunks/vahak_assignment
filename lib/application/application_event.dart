import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//Base Class for Bloc Event extends Equatable to make it comparable
abstract class ApplicationBlocEvent extends Equatable {}

class ApplicationInitialEvent extends ApplicationBlocEvent {
  @override
  List<Object> get props => [];
}

class ApplicationLoadInProgress extends ApplicationBlocEvent {
  @override
  List<Object> get props => [];
}

class ApplicationLoadSuccess extends ApplicationBlocEvent {
  ApplicationLoadSuccess();

  @override
  List<Object> get props => [];
}

class ApplicationLoadEvent extends ApplicationBlocEvent {
  ApplicationLoadEvent();

  @override
  List<Object> get props => [];
}

class ApplicationErrorEvent extends ApplicationBlocEvent {
  final String errorMessage;

  ApplicationErrorEvent(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
