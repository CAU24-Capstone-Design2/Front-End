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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: new FloatingActionButton.large(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: new Image.asset('lib/asset/floating_button.png',),
          ),
        ),
      ),
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
          Center(
            child: SingleChildScrollView( // Row vs. SingleChildScrollView : 스크롤 가능
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.insert_photo, size: 160),
                Icon(Icons.insert_photo, size: 160),
                Icon(Icons.insert_photo, size: 160),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
                Icon(Icons.insert_photo, size: 180),
              ],
            ),
          ),),
          SizedBox(height: 30, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                print('스타일 보기');
                Navigator.pushNamed(context, '/tattostyle');
              },
              child: Text('스타일 둘러보기 >',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
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
      ),
    );
  }
}