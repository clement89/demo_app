import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  final String title;
  final Function onClickAction;
  FilledButton({
    @required this.title,
    @required this.onClickAction,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onClickAction,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: Ink(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue, Color(0XFF2978b5)]),
              borderRadius: BorderRadius.circular(25)),
          child: Container(
            width: 200,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
