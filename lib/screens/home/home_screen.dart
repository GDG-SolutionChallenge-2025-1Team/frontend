import 'package:flutter/material.dart';
import 'package:gdg_soogsil_solution_challenge_1team_frontend/widgets/base_layout.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
     child: Center(
       child: ElevatedButton(
         onPressed: () {
           // 또는 스낵바로 화면에 표시
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Hello World')),
           );
         },
         child: const Text('초기 데모 버전임.'),
       ),
     ),
   );
  } 
}