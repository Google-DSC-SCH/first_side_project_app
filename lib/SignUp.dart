import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'Login.dart';

// API 통신
import 'package:dio/dio.dart';

import 'MainPage.dart';

class SignUp extends StatelessWidget {
  // 위젯간 간격(세로)
  double titleFontSize = 17;

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwcController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        // 상태바 높이만큼 띄우기
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // 배경 이미지 적용
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/background.png'))),
        child: GestureDetector(
          /// 외부 클릭시 키보드 숨기기
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    getMobileSizeFromPercent(context, 18, false)),
                // 헤더
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset('assets/img/icon.png'),
                              width: getMobileSizeFromPercent(context, 10, false),
                            ),
                            Text(DateTime.now().year.toString() +
                                "년 " +
                                DateTime.now().month.toString() +
                                "월 " +
                                DateTime.now().day.toString() +
                                "일 ", style: TextStyle(fontSize: logoDateFontSize),)
                          ],
                        ),
                        onTap: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainPage()), (route) => false);
                        },
                      ),
                      Container(height: getMobileSizeFromPercent(context, 7, false),)
                    ],
                  ),
                ),
              ),

              // Body
              body: SingleChildScrollView(
                child: Container(
                    height: getMobileSizeFromPercent(context, 82, false) -
                        MediaQuery.of(context).padding.top * 2,
                    width: double.infinity,
                    // 여기서부터 찐 개발 시작
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// 아이디
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Color(color_mint),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 6, false),
                              child: TextField(
                                controller: idController,
                                decoration: InputDecoration(
                                  hintText: '아이디',
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                        Container(
                          height: 35,
                        ),

                        /// 비밀번호
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Color(color_mint),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 6, false),
                              child: TextField(
                                obscureText: true,
                                controller: pwController,
                                decoration: InputDecoration(
                                  hintText: '비밀번호',
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                        Container(
                          height: 35,
                        ),

                        /// 비밀번호 확인
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Color(color_mint),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                              padding: EdgeInsets.all(5),
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 6, false),
                              child: TextField(
                                obscureText: true,
                                controller: pwcController,
                                decoration: InputDecoration(
                                  hintText: '비밀번호 확인',
                                  border: InputBorder.none,
                                ),
                              )),
                        ),

                        /// 뒤로 가기
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("뒤로 가기",
                                style: TextStyle(fontSize: titleFontSize))),
                        Container(
                          height: 30,
                        ),

                        /// 회원가입 버튼
                        GestureDetector(
                          // 터치 메소드
                          onTap: () async {
                            if (await postSignUp(idController.text,
                                    pwController.text, pwcController.text) ==
                                0) {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        title: Text(
                                          "성공",
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          "회원가입을 완료했습니다.",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          new TextButton(
                                            child: new Text("확인"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ));
                              
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        title: Text(
                                          "오류",
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Text(
                                          "잘못된 정보입니다.",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: <Widget>[
                                          new TextButton(
                                            child: new Text("확인"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ));
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게 하기 위해 사용
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(color_whiteYellow),
                            elevation: 0, // 그림자 깊이
                            child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 50, true),
                                height:
                                    getMobileSizeFromPercent(context, 6, false),
                                child: Text(
                                  "sign up",
                                  style: TextStyle(
                                    fontSize: btnTitleFontSize,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              )),
        ),
      );

  /// 회원가입 메소드
  Future<int> postSignUp(String id, String pw1, String pw2) async {
    if (pw1 != pw2) {
      return -1;
    }
    String postURI = hostURI + 'api/auth/signup';
    Map body = {
      'username': id,
      'password': pw1,
      'role': ['ROLE_ADMIN']
    };
    Dio dio = Dio();
    try {
      var response = await dio.post(postURI, data: body);
      print('====================');
      print('sucess signUp');
      return 0;
    } catch (e) {
      print('====================');
      print('signUpErr');
      return -1;
    }
  }
}
