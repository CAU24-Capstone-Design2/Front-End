import 'package:flutter/material.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar 투명색
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scart',
      debugShowCheckedModeBanner: false,
      routes: {
        // '/home': (context) => HomeScreen(),
        // '/camera': (context) => CameraScreen(),
        // '/myinfo': (context) => MyinfoScreen(),
      },
      initialRoute: '/home',
      // home: MyAppPage(),
    );
  }
}