import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'new_screen.dart';
import 'new_screen2.dart';
import 'new_screen3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:

      const NewCustomFlip(),


      // PageView.builder(
      //     controller: pageController,
      //     scrollDirection: Axis.vertical,
      //     itemCount: 5,
      //     itemBuilder: (context, index) {
      //       return CustomFlip(index: index,);
      //     }),
    );
  }
}

class CustomFlip extends StatefulWidget {
  final int index;
  const CustomFlip({super.key, required this.index});

  @override
  State<CustomFlip> createState() => _CustomFlipState();
}

class _CustomFlipState extends State<CustomFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = Tween<double>(end: math.pi, begin: math.pi * 2)
        .animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    super.initState();
  }


  void resetAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onVerticalDragUpdate: (details) {
      //
      // },
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 200,
                    color: Colors.red,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: 30,
                            child: Text(
                              widget.index.toString(),
                              style:
                                  const TextStyle(fontSize: 100, color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 200,
                        color: Colors.blue,
                        child:  Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                bottom: 30,
                                child: Text(
                                  widget.index.toString(),
                                  style: const TextStyle(
                                      fontSize: 100, color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                          animation: _animation,
                          child: Container(
                            height: 100,
                            width: 200,
                            color: Colors.black,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                _animation.value > 4.71
                                    ?  Positioned(
                                        bottom: 30,
                                        child: Text(
                                          widget.index.toString(),
                                          style: const TextStyle(
                                            fontSize: 100,
                                            color: Colors.white,
                                          ),
                                        ))
                                    : Positioned(
                                  top: 73,
                                        child: Transform(
                                        transform: Matrix4.rotationX(math.pi),
                                        child: Text(
                                          widget.index.toString(),
                                          style: const TextStyle(
                                            fontSize: 100,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                              ],
                            ),
                          ),
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.003)
                                ..rotateX(_animation.value),
                              alignment: Alignment.center,
                              child: child,
                            );
                          }),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
