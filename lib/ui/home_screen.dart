import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vahak/application/application_bloc.dart';
import 'package:vahak/application/application_state.dart';
import 'package:vahak/route/rtn_routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc applicationBloc =
        BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      body: BlocBuilder<ApplicationBloc, ApplicationBlocState>(
        builder: (context, state) {
          debugPrint('application init state --- $state');
          Widget shopWidget;
          if (state is ApplicationInitialState) {
            shopWidget = Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ApplicationDateErrorState) {
            shopWidget = Center(
                child: Text(
              state.errorMessage,
            ));
          } else if (state is ApplicationDataState) {
            shopWidget = ListView.builder(
              shrinkWrap: true,
              itemCount: (applicationBloc.getTopics()).length,
              itemBuilder: (ctx, index) {
                List<dynamic> topic = applicationBloc.getTopics();
                return InkWell(
                  onTap: () {
                     Navigator.pushNamed(context, VahakRoutes.videoScreen,
                        arguments: topic.elementAt(index));

                  },
                  child: Card(
                    child: ListTile(
                        title: Text('   ${topic.elementAt(index)['topic']}')),
                  ),
                );
              },
            );
          } else
            shopWidget = Container();
          return shopWidget;
        },
      ),
    );
  }
}
