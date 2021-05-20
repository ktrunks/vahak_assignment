import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationBlocEvent, ApplicationBlocState> {
  ApplicationBloc(this.context) : super(ApplicationInitialState());

  BuildContext context;

  Map<String, dynamic> data = {};

  @override
  ApplicationBlocState get initialState => ApplicationInitialState();

  /// scaffold which is used for toast or context
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Stream<ApplicationBlocState> mapEventToState(
      ApplicationBlocEvent event) async* {
    if (event is ApplicationInitialEvent) {

      getApplicationData(context);
    } else if (event is ApplicationLoadSuccess) {
      yield ApplicationDataState();
    } else {
    }
  }

  void getApplicationData(BuildContext context) {
    DefaultAssetBundle.of(context)
        .loadString("assets/settings.json")
        .then((value) {
      data = jsonDecode(value);
      this.add(ApplicationLoadSuccess());
    });
  }

  List<dynamic> getTopics() {
    return data['topics'];
  }
}
