import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class MytattooTilt extends StatefulWidget {
  const MytattooTilt({Key? key}) : super(key: key);

  @override
  _MytattooTiltState createState() => _MytattooTiltState();
}

class _MytattooTiltState extends State<MytattooTilt> with TickerProviderStateMixin {
  late AnimationController _controller1, _controller2;
  late Animation<double> _animation1, _animation2;

  @override
  void initState() {
    super.initState();

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
      end: 200.0,
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
    return Container(
      child: AnimatedBuilder(
        animation: _animation1,
        builder: (context, child) {
          return Stack(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_animation1.value),
                child: Image.asset('assets/airplane.jpg'),
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
                            child: Image.asset('assets/nobg_masked_airplane.png'),
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