import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:scart/widget/widget_customNavBar.dart';

import '../widget/widget_customhomeFAB.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({Key? key}) : super(key: key);

  @override
  State<MyinfoScreen> createState() => MyinfoState();
}

class MyinfoState extends State<MyinfoScreen> {
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
          SizedBox(height: 10, width: double.infinity),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.account_circle, size: 100,),
              ),
              Text('김김김 님',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),)
            ]
          ),
          SizedBox(height: 30, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('마이 타투',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
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