import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:scart/widget/widget_customNavBar.dart';

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
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: new Icon(Icons.add),
      ),
      body: Center(
        child: Text('myinfo page'),
      ),
    );
  }
}