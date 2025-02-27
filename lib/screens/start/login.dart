import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "소셜 로그인하기",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await signInWithGoogle();
              },
              child: Card(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/android_light_rd_SI@1x.png'),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    // 로그아웃 처리 (이미 로그인된 계정이 있을 경우)
    await GoogleSignIn().signOut(); // 구글 로그아웃

    // 새로운 구글 로그인 흐름 시작
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null; // 사용자가 로그인 취소 시 null 반환
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // Firestore에 사용자 정보 저장
    final user = userCredential.user;
    if (user != null) {
      try {
        // If user already exists, update their info; otherwise, set new data
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'lastLogin': FieldValue.serverTimestamp(),  // Adding last login time
        }, SetOptions(merge: true)); // Merge true will update existing data without overwriting

        debugPrint('User data saved/updated to Firestore');
      } catch (e) {
        debugPrint("Error saving user data to Firestore: $e");
      }
    }

    return userCredential;
  }
}
