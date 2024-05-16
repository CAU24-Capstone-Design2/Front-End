import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CameraTips extends StatefulWidget {
  CameraTips({Key? key}) : super(key: key);

  @override
  State<CameraTips> createState() => CameraTipsState();
}

class CameraTipsState extends State<CameraTips> with TickerProviderStateMixin {
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 300,
          child: PageView(
            controller: pageController,
            children: [
              Column(
                children: [
                  Image.asset('assets/scarImage.png'),
                  Text('hi'),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/maskImage.png'),
                  Text('hi'),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/tattooImage.png'),
                  Text('hi'),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thinUnderground,
            ),
          ),
        ),
      ],
    );
  }
}