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
      body: Center(
        child: Text('tattostyle page'),
      ),
    );
  }
}