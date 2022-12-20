import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'Real_Main.dart';

class Create_Diary extends StatelessWidget {
  // 위젯간 간격(세로)
  double titleFontSize = 17;
  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;
  // 찐노랑
  int color_realYellow = 0xFFFFD966;
  // 민트
  int color_mint = 0xFFCDF0EA;

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
          body: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 앱 상단 로고
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        22 /
                        100,
                    width: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        10 /
                        100,
                    padding: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            5 /
                            100),
                    child: Image.asset(
                      'assets/img/icon.png',
                    )),

                // 세로 화면의 22% 비율부터 시작
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        78 /
                        100,
                    width: MediaQuery.of(context).size.width,
                    // 여기서부터 찐 개발 시작
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 제목
                        Column(
                          children: [
                            Text("후기 작성",
                                style: TextStyle(fontSize: titleFontSize)),
                            Container(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Color(color_whiteYellow),
                              elevation: 0, // 그림자 깊이
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 50, false),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            width: getMobileSizeFromPercent(context, 80, true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_mint),
                                  elevation: 0, // 그림자 깊이
                                  child: GestureDetector(
                                    onTap: () {
                                      print("완료 버튼 눌림");
                                    },

                                    // 로그인 버튼
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        width: getMobileSizeFromPercent(
                                            context, 30, true),
                                        height: getMobileSizeFromPercent(
                                            context, 6, false),
                                        child: Text(
                                          "완료",
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        )),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_mint),
                                  elevation: 0, // 그림자 깊이
                                  child: GestureDetector(
                                    onTap: () {
                                      print("취소 버튼 눌림");
                                    },

                                    // 로그인 버튼
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(5),
                                        width: getMobileSizeFromPercent(
                                            context, 30, true),
                                        height: getMobileSizeFromPercent(
                                            context, 6, false),
                                        child: Text(
                                          "취소",
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    )),
              ]),
        ),
      );
}
