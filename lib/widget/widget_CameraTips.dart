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
          height: 340,
          child: PageView(
            controller: pageController,
            children: [
              Column(
                children: [
                  Image.asset('assets/tips1.png', height: 250,),
                  SizedBox(height: 40,),
                  Text(' 1. 흉터 사진을 찍을 때 1:1 비율로 촬영하면\n 타투 도안이 더 잘 생성됩니다.', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/tips2.png', height: 250,),
                  SizedBox(height: 40,),
                  Text(' 2. 흉터 사진을 찍을 때 카메라 중앙에 맞춰서\n 흉터 부위를 촬영해주세요!', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/tips2.png', height: 250,),
                  SizedBox(height: 40,),
                  Text(' 3. 촬영시에 그림자가 없는 환경에서 흉터 \n 부위가 최대한 평평하게 보일 수 있도록\n 구도를 잡아주세요.', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  )),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30,),
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