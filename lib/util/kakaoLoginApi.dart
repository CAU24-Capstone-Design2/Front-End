import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLoginApi {
  signWithKakao() async {
    final UserApi api = UserApi.instance;
    if (await isKakaoTalkInstalled()) {
      try{
        api.loginWithKakaoTalk().then((_) {
          return api.me();
        });
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 의도적인 로그인 취소인 경우 -> 로그인 시도 없이 로그인 취소로 처리(예: 뒤로가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        // 카카오톡에 연결된 계정이 없는 경우 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return api.me();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        return api.me();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}

class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;

  UserController({required this.kakaoLoginApi});

  void kakaoLogin() async {
    kakaoLoginApi.signWithKakao().then((user) {
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    });
  }
}