import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../util/kakaoController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginState();
}
class LoginState extends State<LoginScreen> {
  final storage = FlutterSecureStorage();

  Future<bool> requestLogin() async {
    final url = Uri.http('165.194.104.133:8888', '/api/auth/login'); //165.194.104.144:8888 cvmlserver4

    try {
      var accessToken = await storage.read(key: 'accessToken');

      http.Response response = await http.post(url, headers: {'accessToken':accessToken!, 'Content-Type':'application/json'});

      if (response.statusCode == 200) {
        print("백엔드 로그인 성공!");
        //print(response.body);
        Map<String, dynamic> bodyMap = jsonDecode(response.body);
        Map<String, dynamic> dataMap = await bodyMap['data'];
        //print(dataMap['accessToken']);

        storage.write(
            key: 'appToken',
            value: dataMap['accessToken']
        );

        return true;
      } else {
        print("백엔드 로그인 실패!");
        return false;
      }
    } catch(e) {
      Exception(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _profile(),
            _nickname(),
            _loginButton(),
          ],
        ),
      ),
    );
  }

  Widget _profile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Consumer<UserController>(builder: (context, controller, child) {
          final String? src = controller.user?.kakaoAccount?.profile?.thumbnailImageUrl;
          // controller.user?.kakaoAccount?.profile?.thumbnailImageUrl
          if (src != null) {
            return Image.network(src, fit: BoxFit.cover);
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }),
      ),
    ),
  );

  Widget _nickname() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      final String? name = controller.user?.kakaoAccount?.profile?.nickname;
      // controller.user?.kakaoAccount?.profile?.nickname;
      if (name != null) {
        return Text(name, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ));
      } else {
        return const Text("로그인이 필요합니다", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ));
      }
    }),
  );

  Widget _loginButton() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      if (controller.user != null) {
          return GestureDetector(
            onTap: () {
              requestLogin().then((value) {
                if (value) {
                Navigator.pushReplacementNamed(context, '/home');
              }});
              //Navigator.pushReplacementNamed(context, '/home'); // 백엔드랑 연동시엔 지우기!
            },
            child: Image.asset("assets/startbar.png"),
          );
      } else {
          return GestureDetector(
          onTap: context.read<UserController>().kakaoLogin,
          child: Image.asset("assets/kakao/kakao_login_medium_wide.png"),
          );
      }
    },)
  );
}