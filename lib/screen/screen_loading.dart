import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => LoadingState();
}

class LoadingState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('ScArt에서 사용자의 이미지를\n열심히 학습하고 있어요.',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),),
            ),
          SizedBox(height: 100, width: double.infinity),
          Container(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text('작업이 완료되면 알려드릴게요. 😎',
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
                child: Lottie.network(
                    'https://lottie.host/80a8a735-14cf-4777-b7a0-876960039bcd/bMwGupgSH7.json',
                    repeat: true,
                    animate: true,
                    delegates: LottieDelegates(
                        values: [
                          ValueDelegate.color(
                              const ['**', 'Circle 1', '**'],
                              value: Color(0xFF7755EC)
                          ),
                          ValueDelegate.color(
                              const ['**', 'Circle 2', '**'],
                              value: Color(0xFFA5ACB5)
                          ),
                          ValueDelegate.color(
                              const ['**', 'Circle 3', '**'],
                              value: Color(0xFF528CEF)
                          ),
                          ValueDelegate.color(
                              const ['**', 'Circle 4', '**'],
                              value: Color(0xFF4B2CEA)
                          )
                        ]
                    )
                ),
              )
            ],
          )
          ],
        )
    );
  }
}
