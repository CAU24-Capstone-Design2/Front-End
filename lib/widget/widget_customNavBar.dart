import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  // 하단 네비게이션바 인덱스
  static int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xff77A5FF), width: 2.0))
      ),
      child: BottomNavigationBar(
        onTap: (int index) => setState(() {
          _selectedIndex = index;
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/camera');
              break;
            case 1:
              Navigator.pushNamed(context, '/myinfo');
              break;
            default:
          }
        }),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera),
              label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Mypage'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
      ),
    );
  }
}