import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scart/util/kakaoController.dart';

class FailedScreen extends StatefulWidget {
  const FailedScreen({Key? key}) : super(key: key);

  @override
  State<FailedScreen> createState() => FailedState();
}

class FailedState extends State<FailedScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    new Future.delayed(
        const Duration(seconds: 4),
            () => Navigator.pushReplacementNamed(context, '/home')
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Consumer<UserController>(builder: (context, controller, child) {
          final String? name = controller.user?.kakaoAccount?.profile?.nickname;
          if (name != null) {
            return Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(name + " 님의 타투 도안 생성 중 에러가 발생했어요 ㅠㅠ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),
            );
          } else {
            return SizedBox(height: 100,);
          }
        }),
        SizedBox(height: 100, width: double.infinity),
        Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Tip을 참고하여 다시 촬영부탁드려요!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
              ]
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80, width: double.infinity),
            SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset("assets/lottie/failed.json")
            )
          ],
        )
      ],
    );
  }
}