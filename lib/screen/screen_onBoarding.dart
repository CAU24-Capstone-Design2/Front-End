import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);
  bool isLastPage = false;

  final animations = [
    "assets/lottie/search.json",
    "assets/lottie/camera.json",
    "assets/lottie/hola.json",
  ];

  final description_title = [
    "Search for Style",
    "One Click",
    "Try it on your skin",
  ];

  final description_info = [
    "Hospitals Near Me By Distinct",
    "Accurate And Detailed Insights",
    "Nearby Pharmacies at a Glance",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: animations.length ,
              itemBuilder: (context, index) {
                  return _PageLayout(
                    animation: animations[index],
                    title: description_title[index],
                    info: description_info[index],
                    isLastPage: index == animations.length - 1,
                  );
                },
              onPageChanged: (value) {
                setState(() {
                  isLastPage = value == animations.length - 1;
                });
                selectedIndex.value = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 170.0), //text의 간격
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: selectedIndex,
                  builder: (context, index, child) {
                    return Wrap(
                      spacing: 8,
                      children: List.generate(animations.length + 1, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 8,
                          width: selectedIndex.value == index ? 24 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: selectedIndex.value == index
                                ? Color(0xff003466)
                                : Color(0xff003466).withOpacity(0.5),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    (isLastPage == true)
                        ? "Start!"
                        : "Skip",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff003466),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageLayout extends StatelessWidget {
  const _PageLayout({
    required this.animation,
    required this.title,
    required this.info,
    required this.isLastPage,
  });

  final String animation;
  final String title;
  final String info;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(
              animation,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            info,
            style: const TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}