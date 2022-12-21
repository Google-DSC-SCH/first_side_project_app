import 'package:first_side_project_app/CreateDaily.dart';
import 'package:first_side_project_app/ViewDaily.dart';
import 'package:first_side_project_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'AchievementRate.dart';

class Real_Main extends StatelessWidget {
  double touchedPosX = 0;

  // 위젯간 간격(세로)
  double titleFontSize = 17;
  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;
  // 찐노랑
  int color_realYellow = 0xFFFFD966;
  // 민트
  int color_mint = 0xFFCDF0EA;
  // 오늘 날짜
  var td = DateTime.now();

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
            // floatingActionButton: FloatingActionButton(
            //   onPressed: (() => main()),
            //   child: Icon(Icons.arrow_circle_left),
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Stack(
              children: <Widget>[
                Positioned(
                  left: 10,
                  top: getMobileSizeFromPercent(context, 56, false),
                  child: SizedBox(
                    width: 48,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_left, size: 38),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: getMobileSizeFromPercent(context, 56, false),
                  child: SizedBox(
                    width: 48,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_right, size: 38),
                    ),
                  ),
                ),
                Positioned(
                  right: 42,
                  top: getMobileSizeFromPercent(context, 62, false),
                  child: SizedBox(
                    width: 48,
                    child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateDaily())),
                      icon: Icon(Icons.add),
                      iconSize: 35,
                    ),
                  ),
                ),
              ],
            ),

            // Body
            body: GestureDetector(
              // onTap: () {},
              // on
              child: Container(
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
                          Text(
                              td.month.toString() +
                                  "월 " +
                                  td.day.toString() +
                                  "일",
                              style: TextStyle(fontSize: titleFontSize)),
                          Text("\n아자아자 나의 목표",
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
                                height: getMobileSizeFromPercent(
                                    context, 25, false),
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
                                height: getMobileSizeFromPercent(
                                    context, 25, false),
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

                      Card(
                        shape: RoundedRectangleBorder(
                          //모서리를 둥글게 하기 위해 사용
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(color_mint),
                        elevation: 0, // 그림자 깊이
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AchievementRate()));
                          },

                          // 로그인 버튼
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 50, true),
                              height:
                                  getMobileSizeFromPercent(context, 6, false),
                              child: Text(
                                "달성률 보기",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              )),
                        ),
                      ),
                    ],
                  )),
            )),
      );
}
