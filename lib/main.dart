import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokemon/button.dart';
import 'package:pokemon/characters/girl.dart';
import 'package:pokemon/maps/littleroot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // VARIABELS
  double mapX = 5.6;
  double mapY = 0.8;
  double step = 0.4;

  // game stuff
  String currentLocation = 'littleroot';

  // girl character
  int boySprintCount = 0;
  String boyDirection = 'Down';

  // no mans lands for littleroot
  // cordinates we don't wanna go to
  List<List<double>> noMansLandLittleRoot = [
    [2.79, 1.20],
    [-2.8, 1.20],
    [-6.8, -0.39],
    [3.99, -2.0],
    [5.6, 0.0],
    [6.0, 0.0],

  ];

  // ! this is not really working yet. Will update in future.
  bool canMoveTo(String direction, List<List<double>> noMansLand, double x, double y) {
    double stepX = 0;
    double stepY = 0;

    // Determine the next x and y coordinates based on the direction
    if (direction == 'Left') {
      stepX = -step;
      stepY = 0;
    } else if (direction == 'Right') {
      stepX = step;
      stepY = 0;
    } else if (direction == 'Up') {
      stepX = 0;
      stepY = step;
    } else if (direction == 'Down') {
      stepX = 0;
      stepY = -step;
    }

    // Check if the next position is a no man's land
    for (int i = 0; i < noMansLand.length; i++) {
      if ((noMansLand[i][0] == x + stepX && noMansLand[i][1] == y + stepY) ||
          (noMansLand[i][0] == x && noMansLand[i][1] == y)) {
        return false;
      }
    }

    // If it's not a no man's land, return true
    return true;
  }


  void moveUp() {
    // setState(() {
      boyDirection = 'Up';
    //   mapY += step;
    // });
    // animateWalk();
    if(canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)){
      setState(() {
        mapY += step;
      });
    }
    animateWalk();
  }

  void moveDown() {
    // setState(() {
      boyDirection = 'Down';
    //   mapY -= step;
    // });
    // animateWalk();
    if(canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)){
      setState(() {
        mapY -= step;
      });
    }
    animateWalk();
  }

  void moveLeft() {
    // setState(() {
      boyDirection = 'Left';
    //   mapX += step;
    // });
    // animateWalk();

    if(currentLocation == 'littleroot'){
      if(canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)){
        setState(() {
          mapX += step;
        });
      }
      animateWalk();
    }
  }

  void moveRight() {
    // setState(() {
      boyDirection = 'Right';
    //   mapX -= step;
    // });
    // animateWalk();

    if(canMoveTo(boyDirection, noMansLandLittleRoot, mapX, mapY)){
      setState(() {
        mapX -= step;
      });
    }
    animateWalk();
  }

  void pressedA() {}

  void pressedB() {}

  void animateWalk() {
    print('x: ' + mapX.toString() + ', y: ' + mapY.toString());

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        boySprintCount++;
      });

      if (boySprintCount == 3) {
        boySprintCount = 0;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    // little root
                    LittleRoot(x: mapX, y: mapY, currentMap: currentLocation),

                    // Girl character
                    Container(
                      child: MyGirl(
                          boySpriteCount: boySprintCount,
                          direction: boyDirection,
                          location: currentLocation),
                      alignment: Alignment(0, 0),
                    ),
                  ],
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'G A M E B O Y',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        ' \u2764 ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'F L U T T E R',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          // Row 1
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              // left
                              MyButton(
                                text: '\u2190',
                                function: moveLeft,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          ),
                          // Row 2
                          Column(
                            children: [
                              // top
                              MyButton(
                                text: '\u2191',
                                function: moveUp,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              // bottom
                              MyButton(
                                text: '\u2193',
                                function: moveDown,
                              ),
                            ],
                          ),
                          // Row 3
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              // right
                              MyButton(
                                text: '\u2192',
                                function: moveRight,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                              ),
                              MyButton(
                                text: 'b',
                                function: pressedB,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              MyButton(
                                text: 'a',
                                function: pressedA,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    'C R E A T E D B Y O S H',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
