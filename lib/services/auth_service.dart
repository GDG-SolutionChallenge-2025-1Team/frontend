import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import "package:gdg_soogsil_solution_challenge_1team_frontend/utils/token_storage.dart";

import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Google 로그인 메서드
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', googleAuth.idToken ?? '');

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      final String? idToken = await user?.getIdToken();

      if (idToken == null) {
        return null;
      }

      print('Bearer $idToken');

      final response = await http.post(
        Uri.parse(
            'https://soultionchallenge1team-server-231949036311.asia-northeast3.run.app/login'), // 🔁 백엔드 주소로 교체
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final jwt = responseBody['jwt_token'];

        await TokenStorage.saveToken(jwt);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// 로그아웃 메서드
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
