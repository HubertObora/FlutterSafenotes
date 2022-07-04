// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MainPageContainer extends StatelessWidget {
  final String text;
  final bool isBold;
  MainPageContainer({Key? key, required this.text, required this.isBold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isBold) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Center(
          child: Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Center(
          child: Container(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }
}
