import 'dart:ui';

import 'package:flutter/material.dart';

class TattoostyleTwo extends StatefulWidget {
  const TattoostyleTwo({Key? key}) : super(key: key);

  @override
  _TattoostyleTwoState createState() => _TattoostyleTwoState();
}

class _TattoostyleTwoState extends State<TattoostyleTwo> {
  var tattooStyleImages = List.empty(growable : true);

  @override
  void initState() {
    super.initState();

    if (tattooStyleImages.isEmpty) {
      for (int i = 1; i <= 16; i++) {
        var image = 'assets/tattoo/neotraditional' + i.toString() + '.png';
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
            ' 네오 트레디셔널이란 올드스쿨을 현대에 맞게 변화시킨 타투 스타일입니다.\n굵은 선과 밝은 색상, 최소한의 음영을 사용한 것이 특징입니다. \n\n 아래 예시 도안을 봐주세요!',
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
              ),        ),
      ],
    );
  }
}