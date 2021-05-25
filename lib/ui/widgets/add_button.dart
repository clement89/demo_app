import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Function onClickAction;
  final IconData iconData;
  AddButton({
    @required this.title,
    @required this.onClickAction,
    this.iconData,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(
              iconData == null ? Icons.add_rounded : this.iconData,
              color: white,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black87,
          elevation: 13,
          primary: Color(0XFFf21170),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
        onPressed: onClickAction);
  }
}
