import 'package:flutter/material.dart';

class CustomHomeFAB extends StatelessWidget {
  const CustomHomeFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}