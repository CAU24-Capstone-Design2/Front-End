import 'dart:ui';

import 'package:flutter/material.dart';

class TattostyleThree extends StatelessWidget {
  const TattostyleThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 40, width: double.infinity),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            '라인 워크란 명암 묘사 없이 얇은 선을 땁니다. 주로 여성들이 선호하고 여백의 미다 돋보이는 것이 특징입니다. \n아래 예시 도안을 봐주세요!',
            softWrap: true,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 40, width: double.infinity),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text('스타일 둘러보기 >',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
        ),
        GridView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: 20,
          itemBuilder: (context, index) =>
              Icon(Icons.insert_photo, size: 160),
        ),
      ],
    );
  }
}