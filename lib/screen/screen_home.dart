import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scart/screen/screen_tattostyle.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:lottie/lottie.dart';
import 'package:scart/widget/widget_mytattoTilt.dart';

import '../widget/widget_customAppBar.dart';
import '../widget/widget_customhomeFAB.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {

  List <Icon> icons = [
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomHomeFAB(),
      body: ListView(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('마이 타투',
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
              children: [for(var icon in icons) GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          content: MytattoTilt(),
                          actions: [
                            TextButton(
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                  );
                },
                child: Icon(Icons.insert_photo, size: 160),
              )],
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
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Color(0xffEEF4FF),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
          ),
        ],
      ),
    );
  }
}