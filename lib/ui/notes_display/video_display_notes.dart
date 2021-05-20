import 'package:flutter/material.dart';

class VideoDisplayNotesWidget extends StatelessWidget {
  final String notes;

  final Function onClickOfDismiss;

  VideoDisplayNotesWidget(this.notes, this.onClickOfDismiss);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            notes,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: onClickOfDismiss, child: Text('Dismiss Note'))
        ],
      ),
    );
  }
}
