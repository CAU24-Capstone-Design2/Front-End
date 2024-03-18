import 'package:flutter/material.dart';
import 'package:scart/screen/screen_tattostyle.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final screen = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          SizedBox(height: 30, width: double.infinity),
          ElevatedButton(
            onPressed: () {
              print('스타일 보기');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TattostyleScreen()),
              );
            },
            child: Text('스타일 둘러보기', style: TextStyle(fontSize: 20),),
          ),
          SingleChildScrollView( // Row vs. SingleChildScrollView : 스크롤 가능
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
                Icon(Icons.check_box, size: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}