import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
       child: ElevatedButton(
         onPressed: () {
           // 또는 스낵바로 화면에 표시
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Hello World')),
           );
         },
         child: const Text('초기 데모 버전임.'),
       ),
     );
  } 
}