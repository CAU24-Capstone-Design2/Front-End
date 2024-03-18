import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Myinfo'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Text('myinfo page'),
      ),
    );
  }
}