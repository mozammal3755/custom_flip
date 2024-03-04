import 'package:flutter/material.dart';
import 'dart:math' as math;

class NewCustomFlip3 extends StatefulWidget {
  const NewCustomFlip3({super.key}) ;

  @override
  State<NewCustomFlip3> createState() => _CustomFlip3State();
}

class _CustomFlip3State extends State<NewCustomFlip3>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void resetAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          // Detecting gestures
          // onHorizontalDragUpdate: (details) {
          //   // Determine swipe direction
          //   if (details.delta.dx < 0) {
          //     _animationController.forward();
          //   } else {
          //     _animationController.reverse();
          //   }
          // },
          onVerticalDragUpdate: (details) {
            print('up x - ${details.globalPosition.dx} :up y -${details.globalPosition.dy}');
            // setState(() {
            //   _gestureType = 'Vertical Swipe'; // Updating gesture type
            // });
            resetAnimation();
          },
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget? child) {
              return  Stack(
                children: [
                  // Front page
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateY(0),
                    child: _buildFrontPage(),
                  ),
                  // Back page
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.002)
                      ..rotateX(math.pi * (_animation.value - 1)),
                    child: _buildBackPage(),
                  ),
                ],
              );
            },

          ),
        ),
      ),
    );
  }

  Widget _buildFrontPage() {
    return Container(
      color: Colors.white,
      width: 300,
      height: 300,
      child: Center(
        child: Text(
          'Front Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  Widget _buildBackPage() {
    return Container(
      color: Colors.blue,

      child: Center(
        child: Text(
          'Back Page',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

