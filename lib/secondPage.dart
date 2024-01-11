import 'dart:math';

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation rotateAnimation;
  late Animation scaleAnimation;
  late Animation transAnimation; // 위치이동

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    rotateAnimation =
        Tween<double>(begin: 0, end: pi * 10).animate(animationController);
    scaleAnimation =
        Tween<double>(begin: 1, end: 0).animate(animationController);
    transAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(200, 200))
            .animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Example')),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: rotateAnimation,
                  builder: (context, widget) {
                    return Transform.translate(
                      offset: transAnimation.value,
                      child: Transform.rotate(
                        angle: rotateAnimation.value,
                        child: Transform.scale(
                          scale: scaleAnimation.value,
                          child: widget,
                        ),
                      ),
                    );
                  },
                  child: const Hero(
                      tag: 'detail', child: Icon(Icons.cake, size: 150))),
              ElevatedButton(
                child: const Text('로테이션 시작하기'),
                onPressed: () {
                  animationController.forward();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
