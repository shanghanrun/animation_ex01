import 'package:animation_ex01/people.dart';
import 'package:animation_ex01/secondPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Animation example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AnimationApp());
  }
}

class AnimationApp extends StatefulWidget {
  const AnimationApp({super.key});

  @override
  State<AnimationApp> createState() => _AnimateState();
}

class _AnimateState extends State<AnimationApp> {
  List<People> peoples = [];
  int i = 0; // index
  Color weightColor = Colors.blue;
  double opacity = 1;

  void changeWeightColor(double weight) {
    if (weight < 60) {
      weightColor = Colors.blue;
    } else if (weight < 80) {
      weightColor = Colors.yellow;
    } else {
      weightColor = Colors.red;
    }
  }

  @override
  void initState() {
    super.initState();
    peoples.add(People('탐', 180, 92));
    peoples.add(People('메리', 162, 55));
    peoples.add(People('제인', 180, 79));
    peoples.add(People('스미스', 130, 40));
    peoples.add(People('존', 194, 140));
    peoples.add(People('바트', 100, 80));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation example')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text('이름 : ${peoples[i].name} '),
                    ),
                    AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(seconds: 2),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        width: 50,
                        height: peoples[i].height,
                        child: Text('키 ${peoples[i].height}',
                            textAlign: TextAlign.center),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInCubic,
                      color: weightColor,
                      width: 50,
                      height: peoples[i].weight,
                      child: Text('몸무게 ${peoples[i].weight}',
                          textAlign: TextAlign.center),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.linear,
                      color: Colors.pink,
                      width: 50,
                      height: peoples[i].bmi,
                      child: Text(
                          'bmi ${peoples[i].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('다음 친구'),
                onPressed: () {
                  setState(() {
                    if (i < peoples.length - 1) {
                      i++;
                      changeWeightColor(peoples[i].weight);
                      opacity == 1 ? opacity = 0 : opacity = 1;
                    }
                  });
                },
              ),
              ElevatedButton(
                child: const Text('이전 친구'),
                onPressed: () {
                  setState(() {
                    if (i > 0) {
                      i--;
                      changeWeightColor(peoples[i].weight);
                      opacity == 1 ? opacity = 0.2 : opacity = 1;
                    }
                  });
                },
              ),
              ElevatedButton(
                child: const SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Hero(tag: 'detail', child: Icon(Icons.cake)),
                      Text('이동하기'),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
