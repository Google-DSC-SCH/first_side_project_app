import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget{
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
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 앱 상단 로고
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 22 / 100,
              width: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 10 / 100,
              padding: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 5 / 100),
              child: Image.asset('assets/img/icon.png',)
            ),
            // 세로 화면의 22% 비율부터 시작
            Container(
              height: (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top) * 78 / 100,
              width: MediaQuery.of(context).size.width,
              // 여기서부터 찐 개발 시작
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