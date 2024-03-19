import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:scart/widget/widget_customNavBar.dart';

class TattostyleScreen extends StatefulWidget {
  const TattostyleScreen({Key? key}) : super(key: key);

  @override
  State<TattostyleScreen> createState() => TattostyleState();
}

class TattostyleState extends State<TattostyleScreen> {
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
        child: Text('tattostyle page'),
      ),
    );
  }
}