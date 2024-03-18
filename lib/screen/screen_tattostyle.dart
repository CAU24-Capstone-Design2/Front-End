import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('TattoStyle'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Center(
        child: Text('tattostyle page'),
      ),
    );
  }
}