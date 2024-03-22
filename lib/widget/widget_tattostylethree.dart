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
            '수채화 타투는 아름답고 부드럽게 혼합된 색상을 특징으로 합니다. \n아래 예시 도안을 봐주세요!',
            softWrap: true,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 40, width: double.infinity),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text('스타일 둘러보기',
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
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset('assets/tatto/watercolor1.jpg'),
                ),
              ),        ),
      ],
    );
  }
}