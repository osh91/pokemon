import 'package:flutter/material.dart';

class MyGirl extends StatelessWidget {
  final int boySpriteCount; // 0 for standing , 1-2 walking
  final String direction;
  final String location;
  double height = 20;

  MyGirl(
      {Key? key,
      required this.location,
      required this.boySpriteCount,
      required this.direction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (location == 'littleroot') {
      height = 20;
    } else if (location == 'pokelab') {
      height = 30;
    } else if (location == 'battleground' ||
        location == 'attackoptions' ||
        location == 'battlerfinishedscreen') {
      height = 0;
    }

    return Container(
      height: 27,
      child: Image.asset(
          'lib/images/girl' + direction + boySpriteCount.toString() + '.png',
          fit: BoxFit.cover),
    );
  }
}
