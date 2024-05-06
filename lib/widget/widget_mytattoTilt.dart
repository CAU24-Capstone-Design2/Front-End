import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MytattoTilt extends StatefulWidget {
  const MytattoTilt({Key? key}) : super(key: key);

  @override
  _MytattoTiltState createState() => _MytattoTiltState();
}

class _MytattoTiltState extends State<MytattoTilt> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 60),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-1.0),
        child: Stack(
          children: [
            Image.asset('assets/airplane.jpg'),
            Transform.translate(
              offset: const Offset(200.0, 0.0),
              child: SimpleShadow(
                color: Colors.cyanAccent,
                opacity: 1,
                sigma: 5,
                offset: const Offset(0, 0),
                child: Image.asset('assets/nobg_masked_airplane.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}