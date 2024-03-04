import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class NewCustomFlip extends StatefulWidget {
  // final int index;

  const NewCustomFlip({super.key, m,});

  @override
  State<NewCustomFlip> createState() => _CustomFlipState();
}

class _CustomFlipState extends State<NewCustomFlip>
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
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          resetAnimation();
        },
        child: Stack(
          children: [
            Column(
              children: [
                // _bodyColumn(),
                Stack(
                  children: [
                    Container(
                      // width: 300,
                      // height: 300,
                      child: Positioned(
                          // bottom: 30,
                          child: _bodyColumn()),
                    ),
                    Positioned(
                      top: 280,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedBuilder(
                          animation: _animation,
                          child: Container(
                            // width: 300,
                            // height: 300,
                            child: _animation.value > 4.71
                                ? _newsSection()
                                : Transform(
                                    transform: Matrix4.rotationX(math.pi),
                                    child: _newsSection(),
                                  ),
                          ),
                          builder: (context, child) {
                            return Transform(
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.003)
                                ..rotateX(_animation.value),
                              alignment: Alignment.topCenter,
                              child: child,
                            );
                          }),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Column _bodyColumn (){
    return Column(
      children: [
        _imageBanner(context),

        _newsSection()
      ],
    );
  }

  Stack _imageBanner(
    BuildContext context,
  ) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Top Image Section
        topImageSection(),

        // Promo Code
        Positioned(
          bottom: 10,
          left: 50,
          child: _buildPromoCode(),
        ),

        // BookMark Button
      ],
    );
  }

  Container topImageSection() {
    return Container(
        width: double.infinity,
        // decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(120))),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Image.network(
              'https://media.istockphoto.com/id/646044454/photo/dhaka-bangladesh.jpg?s=2048x2048&w=is&k=20&c=IFRyksDElJQXsrgWvUVPT5IFXXXFWbR1irLIIDz--oY=',
              fit: BoxFit.cover,
            )));
  }

  Container _buildPromoCode() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      // width: Utils.scrHeight * .14,
      // height: 66,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: const Text('ABCDEFGHI',
          style: TextStyle(color: Colors.black, fontSize: 20)),
    );
  }

  Container _newsSection() {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 27),
          const SizedBox(
            // width: Utils.scrHeight * .342,
            child: Text(
              'Special ‘Aastha’ train to Ayodhya flagged off from Goa',
              style: TextStyle(color: Colors.black, fontSize: 19),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            height: 300,
            child: Text(
              'A special “Aastha” train carrying around 2,000 pilgrims to Ayodhya in Uttar Pradesh has been flagged off from Goa.\n Chief Minister Pramod Sawant, state BJP president Sadanand Shet Tanavade and other MLAs were present at the flagging off ceremony held on Monday evening at Thivim railway station in North Goa district.\n\n',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          socialLinkSection(),
          // SizedBox(height: Utils.scrHeight * .02),
        ],
      ),
    );
  }

  SizedBox socialLinkSection() {
    return SizedBox(
      width: 398,
      height: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Source Link : ',
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              const SizedBox(width: 2),
              GestureDetector(
                onTap: () async {},
                child: const Text('https://indianexpress.com/',
                    style: TextStyle(color: Colors.black, fontSize: 14)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
