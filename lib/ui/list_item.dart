import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListItem extends StatelessWidget{
  ListItem(this.title, this.score);
  final String title;
  final int? score;
  @override
  Widget build(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top:6.0,left: 8.0,right: 8.0, bottom: 2.0),
        child: Container(
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10), bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5)),
              ),
              child: Column(
                children: [
                  Expanded(child: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22.0),))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: score!/100.toDouble(),
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      );
  }

}