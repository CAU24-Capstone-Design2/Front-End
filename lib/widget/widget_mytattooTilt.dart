import 'package:flutter/material.dart';
import 'package:scart/util/Tattoo.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MytattooTilt extends StatefulWidget {
  const MytattooTilt({Key? key, required this.tattooData}) : super(key: key);

  final Tattoo tattooData;

  @override
  _MytattooTiltState createState() => _MytattooTiltState();
}

class _MytattooTiltState extends State<MytattooTilt> with TickerProviderStateMixin {
  late AnimationController _controller1, _controller2;
  late Animation<double> _animation1, _animation2;
  var isNotNull = false;

  @override
  void initState() {
    super.initState();

    if (widget.tattooData != null) {
      setState(() {
        isNotNull = true;
      });
    }

    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation1 = Tween<double>(
      begin: 0,
      end: -0.9,
    ).animate(_controller1);

    _controller1.forward();

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation2 = Tween<double>(
      begin: 0,
      end: 180.0,
    ).animate(_controller2);

    _controller2.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isNotNull ? Container() : Container(
          child: AnimatedBuilder(
            animation: _animation1,
            builder: (context, child) {
              return Stack(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_animation1.value),
                    child: Image.network(widget.tattooData.scarImage, width: 130),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_animation1.value),
                    child: AnimatedBuilder(
                      animation: _animation2,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_animation2.value, 0.0),
                          child: SimpleShadow(
                            color: Colors.cyanAccent,
                            opacity: 1,
                            sigma: 5,
                            offset: const Offset(0, 0),
                            child: Image.network(widget.tattooData.segmentImage, width: 130),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
  }
}