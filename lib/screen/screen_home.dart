import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scart/screen/screen_tattostyle.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:lottie/lottie.dart';

import '../widget/widget_customAppBar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: ListView(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('마이 타투 >',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
          ),
          SingleChildScrollView( // Row vs. SingleChildScrollView : 스크롤 가능
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('스타일 보기');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TattostyleScreen()),
              );
            },
            child: Text('스타일 둘러보기', style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}