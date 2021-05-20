import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/route/rtn_routes.dart';

import 'application/application_bloc.dart';
import 'application/application_event.dart';

class VahakApp extends StatefulWidget {
  VahakApp();

  @override
  RTNAppState createState() => RTNAppState();
}

class RTNAppState extends State<VahakApp> {
  @override
  void initState() {
    super.initState();
    final router = FluroRouter();
    VahakRoutes.router = router;
    VahakRoutes.configureRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (_) =>
              ApplicationBloc(context)..add(ApplicationInitialEvent()),
        ),
      ],
      child: MaterialApp(
          initialRoute: VahakRoutes.root,
          debugShowCheckedModeBanner: false,
          title: 'LAI-III',
          onGenerateRoute: VahakRoutes.router.generator,
          theme: ThemeData(
              primaryColor: Colors.black,
              backgroundColor: Colors.white,
              buttonColor: Colors.black,
              accentColor: Colors.blue,
              unselectedWidgetColor: Colors.black,
              primaryIconTheme: IconThemeData(
                color: Colors.black,
              ),
              errorColor: Colors.red,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              accentIconTheme: IconThemeData(
                color: Colors.white, // FAB icon color
              ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
