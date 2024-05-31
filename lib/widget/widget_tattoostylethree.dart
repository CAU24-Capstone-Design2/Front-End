import 'dart:ui';

import 'package:flutter/material.dart';

class TattoostyleThree extends StatefulWidget {
  const TattoostyleThree({Key? key}) : super(key: key);

  @override
  _TattoostyleThreeState createState() => _TattoostyleThreeState();
}

class _TattoostyleThreeState extends State<TattoostyleThree> {
  var tattooStyleImages = List.empty(growable : true);

  @override
  void initState() {
    super.initState();

    if (tattooStyleImages.isEmpty) {
      for (int i = 1; i <= 16; i++) {
        var image = 'assets/tattoo/watercolor' + i.toString() + '.png';
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
            ' 수채화 타투는 아름답고 부드럽게 혼합된 색상을 특징으로 하고 패션 타투, 감성 타투 카테고리에서 많은 인기를 얻고 있습니다.\n\n 아래 예시 도안을 봐주세요!',
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