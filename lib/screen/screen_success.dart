import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scart/util/kakaoController.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => SuccessState();
}

class SuccessState extends State<SuccessScreen> with TickerProviderStateMixin {
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
              child: Text(name + " 님의 타투 도안이 완성되었습니다!",
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
                Text("지금 마이 타투에서 결과를 확인해주세요",
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
                child: Lottie.asset("assets/lottie/success.json")
            )
          ],
        )
      ],
    );
  }
}