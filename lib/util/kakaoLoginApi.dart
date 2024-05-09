import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KakaoLoginApi {
  signWithKakao() async {
    final UserApi api = UserApi.instance;
    final storage = FlutterSecureStorage();
    if (await isKakaoTalkInstalled()) {
      try{
          OAuthToken token = await api.loginWithKakaoTalk();
          storage.write(
            key: 'accessToken',
            value: token.accessToken
          );
          print("access token: " + token.accessToken);
          return api.me();

      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 의도적인 로그인 취소인 경우 -> 로그인 시도 없이 로그인 취소로 처리(예: 뒤로가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }

        // 카카오톡에 연결된 계정이 없는 경우 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          storage.write(
              key: 'accessToken',
              value: token.accessToken
          );
          print("access token: " + token.accessToken);
          return api.me();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        storage.write(
            key: 'accessToken',
            value: token.accessToken
        );
        print("access token: " + token.accessToken);
        return api.me();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}