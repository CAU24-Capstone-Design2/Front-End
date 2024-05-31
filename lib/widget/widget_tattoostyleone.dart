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
        var image = 'assets/tattoo/realism' + i.toString() + '.png';
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
            ' 리얼리즘은 사실성, 현실성을 뜻하는 말로 \n사진이나 인물, 사물의 모습을 그대로 재현하는 것을 의미합니다.  \n\n 아래 예시 도안을 봐주세요!',
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
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
            child: Image.asset(tattooStyleImages[index], fit: BoxFit.fill,),
          ),
          ),
        ),
      ],
    );
  }
}