import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'BaseFile.dart';

import 'BaseFile.dart';
import 'SignUp.dart';
import 'MainPage.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Login extends StatefulWidget{
  @override
  State createState() => _Login();
}

class _Login extends State {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  final _fileName = 'idpw.txt';
  late String _path;
  
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  /// 자동 로그인
  Future<void> init() async {
    // await requestPermissions();

    // 기본 경로 얻기
    final directory = await getApplicationDocumentsDirectory();
    _path = directory.path;

    // await writeFile("");
    String text = await readFile();
    if (text != ''){
      print("로그인됨");
      List ls = text.split('\n');
      print(ls);
      if(await login(ls[0].toString(),ls[1].toString()) == 0){
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => MainPage()));
      }

    }
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

              /// Body
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

                        /// 공백
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
                                obscureText:true,
                                controller: pwController,
                                decoration: InputDecoration(
                                  hintText: '비밀번호',
                                  border: InputBorder.none,
                                ),
                              )),
                        ),

                        /// 회원 가입
                        TextButton(
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => SignUp()));
                            },
                            child: Text("sign up",
                                style: TextStyle(fontSize: titleFontSize))),
                        Container(
                          height: 30,
                        ),

                        /// 로그인 버튼
                        GestureDetector(
                          onTap: () async {
                            if (await login(idController.text, pwController.text) == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainPage())).then((value) => logout());
                            }
                            else{
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(16.0)),
                                    title: Text("오류", textAlign: TextAlign.center,),
                                    content: Text("아이디 또는 비밀번호가 잘못되었습니다.", textAlign: TextAlign.center,),
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
                            // 버튼
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

  /// 로그인 메소드
  Future<int> login(String id, String pw) async {
    String postURI = hostURI + 'api/auth/signin';
    Map body = {
      'username': id,
      'password': pw,
    };
    Dio dio = Dio();
    try {
      print(body);
      var response = await dio.post(postURI, data: body);
      token = response.data['accessToken'];
      refreshToken = response.data['refreshToken'];
      await writeFile("$id\n$pw");
      print("sucess Login");
      return 0;
    } catch (e) {
      print("loginErr");
      print(e);
      return -1;
    }
  }

  /// 로그아웃 메소드
  Future<int> logout() async {
    String postURI = hostURI + 'api/auth/signout';
    Dio dio = Dio();
    try {
      // var response = await dio.post(postURI);
      // token = response.data['accessToken'];
      // refreshToken = response.data['refreshToken'];
      print("sucessLogout");
      return 0;
    } catch (e) {
      print(e);
      print("logout Err");
      return -1;
    }
  }

  /// 파일 읽기
  Future<String> readFile() async {
    try {
      final file = File('$_path/$_fileName');
      return file.readAsString();
    } catch (e) {
      return e.toString();
    }
  }

  /// 파일 쓰기
  Future<void> writeFile(String message) async {
    try {
      final file = File('$_path/$_fileName');
      file.writeAsString(message);
    } catch(e){
      print(e);
    }
  }
}
