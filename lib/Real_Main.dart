import 'package:first_side_project_app/ViewDaily.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';

class Real_Main extends StatelessWidget {
  // 위젯간 간격(세로)
  double titleFontSize = 17;
  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;
  // 찐노랑
  int color_realYellow = 0xFFFFD966;
  // 민트
  int color_mint = 0xFFCDF0EA;
  // 오늘 날짜
  // DateTime now = DateTime.now();
  // DateTime date = DateTime(now.month,now.day);

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
                    // 제목
                    Column(
                      children: [
                        Text("아자아자 나의 목표",
                            style: TextStyle(fontSize: titleFontSize)),
                        Container(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(color_whiteYellow),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 27, false),
                              child: ListView(
                                // scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                children: [
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "토익 850점 넘기",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "데이터베이스 자격증 따기",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "알고리즘 마스터하기",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "앱 배포 프로젝트 마무리",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("오늘 하루 나와의 약속",
                            style: TextStyle(fontSize: titleFontSize)),
                        Container(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Color(color_whiteYellow),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 27, false),
                              child: ListView(
                                // scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.all(10),
                                children: [
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "영단어 5개 외우기",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "알고리즘 1문제 풀기",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "연구실 탈출",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                  Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        "앱 배포 프로젝트 마무리",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                    color: Color(color_whiteYellow),
                                    margin: EdgeInsets.all(2),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Color(color_mint),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              height:
                                  getMobileSizeFromPercent(context, 5, false),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      "달성률 보기",
                                      style: TextStyle(fontSize: 21),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ))),
      );
}
