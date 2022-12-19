import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'getMediaQuery.dart';

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(getMobileSizeFromPercent(context, 18, false)),
          child: Container(color: Colors.transparent,child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Container(child: Image.asset('assets/img/icon.png'), height: getMobileSizeFromPercent(context, 10, false),),
              Container()
            ],
          ),),
        ),
        body: Container(
            height: getMobileSizeFromPercent(context, 82, false) - MediaQuery.of(context).padding.top * 2,
            width: double.infinity,
            // 여기서부터 찐 개발 시작
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                      Text("여기서부터 개발하시면 됩니다",
                          style: TextStyle(fontSize: 20)),
                ]))),
  );
}