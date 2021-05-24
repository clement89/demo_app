import 'package:demo_app/ui/pages/fruit_list_page.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomCell extends StatelessWidget {
  final String name;
  const BottomCell({@required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'SHOWING DETAILS OF',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FruitListPage(),
              ),
            );
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0XFFf8f1f1),
                  blurRadius:
                      2, // was 0.5 -- has the effect of softening the shadow
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: red,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
