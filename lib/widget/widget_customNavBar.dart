import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // 하단 네비게이션바 인덱스
  static int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff558FFF)))
      ),
      child: BottomNavigationBar(
        onTap: (int index) => setState(() {
          _selectedIndex = index;
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/camera');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/myinfo');
              break;
            default:
          }
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Mypage'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff77A5FF),
      ),
    );
  }
}