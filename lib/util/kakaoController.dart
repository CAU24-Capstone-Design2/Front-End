import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'kakaoLoginApi.dart';

class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;

  UserController({required this.kakaoLoginApi});

  void kakaoLogin() async {
    kakaoLoginApi.signWithKakao().then((user) {
      if (user != null) {
        _user = user;
        print("\n\n*******Kakao Login Success!!!*****\n\n");
        print(user.kakaoAccount?.profile?.nickname);
        notifyListeners();
      } else {
        print("\n\n*******Kakao Login failed!!!*****\n\n");
      }
    });
  }
}