import 'package:flutter/material.dart';

class ViewDaily extends StatefulWidget{
  @override
  State<ViewDaily> createState() => _ViewDaily();
}

class _ViewDaily extends State<ViewDaily>{
  @override
  Widget build(BuildContext context) => Container(
    // 상태바 높이만큼 띄우기
    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    // 배경 이미지 적용
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/img/background.png')
        )
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 세로 화면의 25% 비율부터 시작
          Container(
            height: MediaQuery.of(context).size.height * 75 / 100,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ElevatedButton(onPressed: ()=>null, child: Text("여기서부터 개발하시면 됩니다"))
              ],
            ),
          )
        ]
      ,)
    ),
  );
}