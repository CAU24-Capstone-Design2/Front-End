import 'dart:ui';

import 'package:flutter/material.dart';

class TattoostyleOne extends StatefulWidget {
  const TattoostyleOne({Key? key}) : super(key: key);

  @override
  _TattoostyleOneState createState() => _TattoostyleOneState();
}

class _TattoostyleOneState extends State<TattoostyleOne> {
  var tattooStyleImages = List.empty(growable : true);

  @override
  void initState() {
    super.initState();

    if (tattooStyleImages.isEmpty) {
      for (int i = 1; i <= 16; i++) {
        var image = 'assets/tattoo/oldschool' + i.toString() + '.png';
        tattooStyleImages.add(image);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 40, width: double.infinity),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            '올드스쿨은 굵고 뚜렷한 외곽선, 원색 계열의 채색과 짙은 명암대비, 2차원의 선명한 이미지가 특징입니다. \n아래 예시 도안을 봐주세요!',
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
        itemCount: tattooStyleImages.length,
        itemBuilder: (context, index) =>
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(tattooStyleImages[index]),
          ),
          ),
        ),
      ],
    );
  }
}