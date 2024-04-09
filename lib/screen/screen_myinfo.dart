import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scart/util/kakaoController.dart';
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
              _profile(),
              _nickname(),
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

  Widget _profile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Consumer<UserController>(builder: (context, controller, child) {
          final String? src = controller.user?.kakaoAccount?.profile?.thumbnailImageUrl;
          // controller.user?.kakaoAccount?.profile?.thumbnailImageUrl
          if (src != null) {
            return Image.network(src, fit: BoxFit.cover);
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }),
      ),
    ),
  );

  Widget _nickname() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      final String? name = controller.user?.kakaoAccount?.profile?.nickname;
      // controller.user?.kakaoAccount?.profile?.nickname;
      if (name != null) {
        return Text(name + " 님");
      } else {
        return const Text("OOO 님");
      }
    }),
  );
}