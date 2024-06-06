import 'dart:ui';

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
  late AnimationController _controller1, _controller2, _controller3;
  late Animation<double> _animation1, _animation2, _animation3;
  var isNotNull = false;

  @override
  void initState() {
    super.initState();

    if (widget.tattooData != null) {
      setState(() {
        widget.tattooData.scarImage.replaceAll('https', 'http');
        widget.tattooData.segmentImage.replaceAll('https', 'http');
        widget.tattooData.synthesisImage.replaceAll('https', 'http');
        isNotNull = true;
      });
    }

    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller1.reverse();
      }
    });

    _animation1 = Tween<double>(
      begin: 0,
      end: -0.9,
    ).animate(_controller1);

    _controller1.forward();

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.reverse();
      }
    });

    _animation2 = Tween<double>(
      begin: 0,
      end: 160.0,
    ).animate(_controller2);


    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller3.reverse();
      }
    });

    _animation3 = Tween<double>(
      begin: 0,
      end: 320.0,
    ).animate(_controller3);
    _controller2.forward();

    _controller3.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
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
                    child: Image.network(widget.tattooData.scarImage, width: 130, ) //Image.network(widget.tattooData.scarImage, width: 130), Image.asset('assets/scarImage.png', width: 130,)
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
                          child: Image.network(widget.tattooData.segmentImage, width: 130, ), //Image.network(widget.tattooData.segmentImage, width: 130), Image.asset('assets/maskImage.png', width: 130,)
                        );
                      },
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(_animation1.value),
                    child: AnimatedBuilder(
                      animation: _animation3,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_animation3.value, 0.0),
                          child: Image.network(widget.tattooData.synthesisImage,
                            color: const Color.fromRGBO(255, 255, 255, 0.75),
                            colorBlendMode: BlendMode.modulate,
                            width: 130,)//Image.network(widget.tattooData.tattooImage, width: 130), Image.asset('assets/tattooImage.png', width: 130,)
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