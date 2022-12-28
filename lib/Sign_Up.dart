import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'Login.dart';

class Sign_Up extends StatelessWidget {
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
                    // 제목
                    Column(children: [
                      Container(
                        height: 5,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          //모서리를 둥글게 하기 위해 사용
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(color_mint),
                        elevation: 0, // 그림자 깊이
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height: getMobileSizeFromPercent(context, 6, false),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '아이디',
                                border: InputBorder.none,
                              ),
                            )),
                      ),
                      Container(
                        height: 35,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          //모서리를 둥글게 하기 위해 사용
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(color_mint),
                        elevation: 0, // 그림자 깊이
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height: getMobileSizeFromPercent(context, 6, false),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '비밀번호',
                                border: InputBorder.none,
                              ),
                            )),
                      ),
                      Container(
                        height: 35,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          //모서리를 둥글게 하기 위해 사용
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(color_mint),
                        elevation: 0, // 그림자 깊이
                        child: Container(
                            padding: EdgeInsets.all(5),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height: getMobileSizeFromPercent(context, 6, false),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: '비밀번호 확인',
                                border: InputBorder.none,
                              ),
                            )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: Text("뒤로 가기", style: TextStyle(fontSize: 17))),
                      Container(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          //모서리를 둥글게 하기 위해 사용
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        color: Color(color_whiteYellow),
                        elevation: 0, // 그림자 깊이
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
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
                                "login",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              )),
                        ),
                      ),
                    ]),
                  ],
                ))),
      );
}
