import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:vahak/route/rtn_routes.dart';
import 'package:vahak/ui/quiz/quiz_get_ready.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen(this.quiz);

  final Map<String, dynamic> quiz;

  @override
  State createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  CountDownController _controller = CountDownController();
  bool isDisplayQuizGetReady = false;
  AnimationController _quizcontroller;
  int levelClock = 15;

  @override
  void initState() {
    super.initState();
    debugPrint(
        'display quiz get ready screen --- ${widget.quiz['display_get_ready']}');
    if (widget.quiz['display_get_ready']) {
      isDisplayQuizGetReady = true;
    }
    _quizcontroller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
                levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
        )
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          /*List<dynamic> questions = widget.quiz['questions'];
          widget.quiz['last_answered'] = widget.quiz['last_answered'] + 1;*/
          isDisplayQuizGetReady = false;
          setState(() {});
          _quizcontroller.reset();
        }
      });

    _quizcontroller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return !isDisplayQuizGetReady
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.blue,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Quiz',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  getQuestionWidget(),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularCountDownTimer(
                    duration: 10,
                    controller: _controller,
                    width: 120,
                    height: 120,
                    color: Colors.white,
                    fillColor: Colors.red,
                    backgroundColor: null,
                    strokeWidth: 5.0,
                    textStyle: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    isReverse: true,
                    isTimerTextShown: true,
                    onComplete: () {
                      print('Countdown Ended');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Hero(
                          tag: 'flipcardHero$index',
                          child: getOptionsWidget(index),
                        ),
                        onTap: () {
                          Map<String, dynamic> quizData = {};
                          quizData['quiz'] = widget.quiz;
                          Map<String, dynamic> quest =
                              (widget.quiz['questions'] as List)
                                  .elementAt(widget.quiz['last_answered']);
                          quest['selected_option'] = index;
                          quizData['key'] = 'flipcardHero$index';
                          quizData['selected_option'] = index;
                          Navigator.pushNamed(
                                  context, VahakRoutes.quizResultScreen,
                                  arguments: quizData)
                              .then((value) {
                            debugPrint(
                                'last answered --- ${widget.quiz['last_answered']}');
                            List<dynamic> questions = widget.quiz['questions'];
                            debugPrint(
                                'total question  --- ${questions.length}');
                            if (widget.quiz['last_answered'] <
                                questions.length - 1) {
                              widget.quiz['last_answered'] =
                                  widget.quiz['last_answered'] + 1;
                              if (widget.quiz['display_get_ready']) {
                                isDisplayQuizGetReady = true;
                              }
                              _quizcontroller.forward();
                              setState(() {});
                            } else {
                              Navigator.pushNamed(
                                  context, VahakRoutes.overAllQuizResultScreen,
                                  arguments: widget.quiz);
                            }
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : quizGetReadyScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _quizcontroller.dispose();
  }

  Widget quizGetReadyScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Countdown(
              animation: StepTween(
                begin: levelClock, // THIS IS A USER ENTERED NUMBER
                end: 0,
              ).animate(_quizcontroller),
            ),
          ],
        ),
      ),
    );
  }

  Widget getOptionsWidget(int index) {
    List<dynamic> options = widget.quiz['questions']
        .elementAt(widget.quiz['last_answered'])['options'];
    return Material(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          color: Colors.yellow[50],
          height: 150,
          child: Center(
            child: Text('${options.elementAt(index)}'),
          ),
        ),
      ),
    );
  }

  Widget getQuestionWidget() {
    debugPrint('last answered --- ${widget.quiz['last_answered']}');
    Map<String, dynamic> question =
        widget.quiz['questions'].elementAt(widget.quiz['last_answered']);
    return Text(
      '${question['question']}',
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
