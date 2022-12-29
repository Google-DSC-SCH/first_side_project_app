import 'package:first_side_project_app/Achieved_Goal.dart';
import 'package:first_side_project_app/Create_Diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'MainPage.dart';

class View_Diary extends StatelessWidget {
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
                    Column(
                      children: [
                        Text("후기", style: TextStyle(fontSize: titleFontSize)),
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
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                getMobileSizeFromPercent(context, 50, false),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: getMobileSizeFromPercent(context, 80, true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  //모서리를 둥글게
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Color(color_mint),
                              onPrimary: Colors.black,
                              minimumSize: Size(80, 40),
                              //width, height
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "수정",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Create_Diary())),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  //모서리를 둥글게
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Color(color_mint),
                              onPrimary: Colors.black,
                              minimumSize: Size(80, 40),
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "삭제",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  //모서리를 둥글게
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Color(color_mint),
                              onPrimary: Colors.black,
                              minimumSize: Size(80, 40),
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "뒤로",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Achieved_Goal())),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      );
}
