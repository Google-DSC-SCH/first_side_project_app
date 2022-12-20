import 'package:flutter/material.dart';
import 'getMediaQuery.dart';

import 'EditDaily.dart';

class AchievementRate extends StatefulWidget {
  @override
  State<AchievementRate> createState() => _AchievementRate();
}

class _AchievementRate extends State<AchievementRate> {

  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;

  // 찐노랑
  int color_realYellow = 0xFFFFD966;

  // 민트
  int color_mint = 0xFFCDF0EA;

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 서버에서 데이터를 받아옴
  }

  @override
  Widget build(BuildContext context) => Container(
    // 상태바 높이만큼 띄우기
    margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    // 배경 이미지 적용
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/img/background.png'))),
    child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:
          Size.fromHeight(getMobileSizeFromPercent(context, 18, false)),
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Image.asset('assets/img/icon.png'),
                  height: getMobileSizeFromPercent(context, 10, false),
                ),
                Container()
              ],
            ),
          ),
        ),

        // Body
        body: Container(
            height: getMobileSizeFromPercent(context, 82, false) -
                MediaQuery.of(context).padding.top * 2,
            width: double.infinity,
            // 여기서부터 찐 개발 시작
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                ]))),
  );
}
