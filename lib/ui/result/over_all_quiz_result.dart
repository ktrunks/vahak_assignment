import 'package:flutter/material.dart';

class OverAllQuizResult extends StatelessWidget {
  final Map<String, dynamic> quiz;

  OverAllQuizResult(this.quiz);

  @override
  Widget build(BuildContext context) {
    debugPrint('quiz data --- ${quiz}');
    List<dynamic> questions = quiz['questions'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Quiz Result',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        itemBuilder: (ctx, index) {
          Map<String, dynamic> question = questions.elementAt(index);
          List<dynamic> options = question['options'];
          return Card(
            child: ListTile(
                title: Text(
                  'Question :  ${question['question']}',
                ),
                subtitle: question['selected_option'] != null
                    ? Text(
                        'Answer :  ${options.elementAt(question['selected_option'])}',
                      )
                    : Text('')),
          );
        },
      ),
    );
  }
}
