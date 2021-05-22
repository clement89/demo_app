import 'package:demo_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 3,
        title: const Text(
          'Add Item',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: red,
            letterSpacing: 1,
          ),
        ),
        leading: Container(),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: blue,
              ),
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}
