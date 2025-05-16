import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import "package:gdg_soogsil_solution_challenge_1team_frontend/utils/token_storage.dart";

import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      print('[AuthService] Google 로그인 시작');

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('[AuthService] Google 로그인 취소됨');
        return null;
      }
      print('[AuthService] Google 사용자 선택됨: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print('[AuthService] Google 인증 정보 획득');
      print('[AuthService] Access Token: ${googleAuth.accessToken}');
      print('[AuthService] ID Token: ${googleAuth.idToken}');

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user == null) {
        print('[AuthService] Firebase 사용자 정보 없음');
        return null;
      }
      print('[AuthService] Firebase 로그인 성공: ${user.email}');

      final String? idToken = await user.getIdToken();
      if (idToken == null) {
        print('[AuthService] Firebase ID 토큰 획득 실패');
        return null;
      }
      print('[AuthService] Firebase ID 토큰: $idToken');

      final response = await http.post(
        Uri.parse(
            'https://soultionchallenge1team-server-231949036311.asia-northeast3.run.app/login'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $idToken',
        },
      );

      print('[AuthService] 백엔드 응답 상태 코드: ${response.statusCode}');
      print('[AuthService] 백엔드 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final jwt = responseBody['jwt_token'];
        print('[AuthService] JWT 토큰 저장: $jwt');

        await TokenStorage.saveToken(jwt);
        return user;
      } else {
        print('[AuthService] 백엔드 로그인 실패: 상태 코드 ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('[AuthService] 예외 발생: $e');
      print('[AuthService] 스택 트레이스: $stackTrace');
      return null;
    }
  }

  /// 로그아웃 메서드
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
