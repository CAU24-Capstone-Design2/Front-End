import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    child: Lottie.asset('assets/lottie/loadingbar.json')
                )
              ],
            )
          ],
        );
  }
}