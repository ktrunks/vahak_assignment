import 'package:fluro/fluro.dart';

import 'rtn_route_handlers.dart';

///
class VahakRoutes {
  ///
  static FluroRouter router;

  /// root end point
  static const String root = '/';

  /// video screen
  static const String videoScreen = 'video_screen';

  /// quiz screen
  static const String quizScreen = 'quiz_screen';

  /// quiz result screen
  static const String quizResultScreen = 'quiz_result_screen';

  /// quiz overall screen
  static const String overAllQuizResultScreen = 'over_all_quiz_result_screen';

  /// configuring routes
  static void configureRoutes(FluroRouter router) {
    router.define(root,
        handler: rootHandler, transitionType: TransitionType.inFromRight);
    router.define(videoScreen,
        handler: videoScreenHandler,
        transitionType: TransitionType.inFromRight);
    router.define(quizScreen,
        handler: quizScreenHandler, transitionType: TransitionType.inFromRight);
    router.define(overAllQuizResultScreen,
        handler: overAllQuizScreenHandler,
        transitionType: TransitionType.inFromRight);
    router.define(
      quizResultScreen,
      handler: quizResultScreenHandler,
      transitionType: TransitionType.fadeIn,
    );
  }
}
