import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scart/screen/screen_camera.dart';
import 'package:scart/screen/screen_home.dart';
import 'package:scart/screen/screen_loading.dart';
import 'package:scart/screen/screen_myinfo.dart';
import 'package:scart/screen/screen_tattostyle.dart';
import 'package:scart/util/generateMaterialColor.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar 투명색
  ));
  await dotenv.load(fileName: '.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['NATIVE_APP_KEY']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'scart',
      theme: ThemeData(
          primarySwatch: generateMaterialColor(Color(0xff77A5FF)),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        '/camera': (context) => CameraScreen(),
        '/myinfo': (context) => MyinfoScreen(),
        '/tattostyle': (context) => TattostyleScreen(),
        '/loading' : (context) => LoadingScreen(),
      },
      initialRoute: '/home',
      // home: MyAppPage(),
    );
  }
}