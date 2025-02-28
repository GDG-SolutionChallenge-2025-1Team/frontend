import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        final String? token = await user.getIdToken();

        if (token != null) {
          print("\n===== ID 토큰 시작 =====");
// 더 작은 청크로 나누어 출력
          int chunkSize = 100; // 더 작은 청크 크기
          for (int i = 0; i < token.length; i += chunkSize) {
            int end =
                (i + chunkSize < token.length) ? i + chunkSize : token.length;
            print("부분 ${i ~/ chunkSize + 1}: ${token.substring(i, end)}");
          }
          print("===== ID 토큰 끝 =====\n");
        }
      }

      return user;
    } catch (e) {
      print("Google 로그인 오류: $e");
      return null;
    }
  }

  /// 로그아웃 메서드
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
