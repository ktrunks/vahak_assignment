import 'dart:math';

import 'package:flutter/material.dart';

class QuizResultScreen extends StatefulWidget {
  Map<String, dynamic> quiz;

  QuizResultScreen({@required this.quiz});

  @override
  SingleFlipCardState createState() => SingleFlipCardState();
}

class SingleFlipCardState extends State<QuizResultScreen> {
  bool _showFrontSide = false;
  double maxScale = 1;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;

    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _showFrontSide = !_showFrontSide);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Hero(
          tag: widget.quiz['key'],
          child: Center(
              child: Container(
            constraints: BoxConstraints.tight(Size.square(200.0)),
            child: _buildFlipAnimation(),
          )),
        ));
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: __transitionBuilder,
      layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
      child: _showFrontSide ? _buildFront() : _buildRear(),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
    );
  }

  Widget _buildFront() {
    List<dynamic> questions = widget.quiz['quiz']['questions'];
    Map<String, dynamic> quest =
        questions.elementAt(widget.quiz['quiz']['last_answered']);
    debugPrint('quiz data --- ${widget.quiz['quiz']['last_answered']}');

    List<dynamic> options = quest['options'];
    debugPrint('quiz data --- ${options}');
    return Material(
      color: Colors.blue,
      child: __buildLayout(
        key: ValueKey(true),
        backgroundColor: Colors.blue.shade700,
        faceName: options.elementAt(widget.quiz['selected_option']),
      ),
    );
  }

  Widget _buildRear() {
    List<dynamic> questions = widget.quiz['quiz']['questions'];
    Map<String, dynamic> quest =
        questions.elementAt(widget.quiz['quiz']['last_answered']);
    List<dynamic> options = quest['options'];

    debugPrint('selected options--- ${widget.quiz['selected_option']}');
    debugPrint('answer--- ${quest['answer']}');

    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: widget.quiz['selected_option'] + 1 == quest['answer']
          ? 'Right'
          : 'Wrong',
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget.key);
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget __buildLayout({Key key, String faceName, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(faceName, style: TextStyle(fontSize: 20.0)),
      ),
    );
  }
}
