import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:scart/widget/widget_customNavBar.dart';

import '../widget/widget_customhomeFAB.dart';
import '../widget/widget_tattoostyleone.dart';
import '../widget/widget_tattoostylethree.dart';
import '../widget/widget_tattoostyletwo.dart';

class TattoostyleScreen extends StatefulWidget {
  const TattoostyleScreen({Key? key}) : super(key: key);

  @override
  State<TattoostyleScreen> createState() => TattoostyleState();
}

class TattoostyleState extends State<TattoostyleScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(83.0),
          child: CustomAppBar(),
        ),
        bottomNavigationBar: CustomNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: CustomHomeFAB(),
        body: Column(
            children: [
            const TabBar(
              indicatorColor: Color(0xff77A5FF),
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              indicatorWeight: 3,
              tabs: [
                Tab(
                  text: '올드스쿨',
                  height: 50,
                ),
                Tab(
                  text: '라인워크',
                  height: 50,
                ),
                Tab(
                  text: '수채화',
                  height: 50,
                ),
              ]
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TattoostyleOne(),
                  TattoostyleTwo(),
                  TattoostyleThree(),
                ],
              ),
            )
      ]
    ),
    ),);
  }
}