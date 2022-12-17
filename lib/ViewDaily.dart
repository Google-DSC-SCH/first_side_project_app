import 'package:flutter/material.dart';

class ViewDaily extends StatefulWidget{
  @override
  State<ViewDaily> createState() => _ViewDaily();
}

class _ViewDaily extends State<ViewDaily>{
  @override
  Widget build(BuildContext context) => Container(
    
    // 배경 이미지 적용
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/background.png')
        )
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ElevatedButton(onPressed: ()=>null, child: Text("aaa"),)
    ),
  );
}