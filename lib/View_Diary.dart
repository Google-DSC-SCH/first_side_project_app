import 'package:dio/dio.dart';
import 'package:first_side_project_app/EditDiary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'MainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class View_Diary extends StatefulWidget {
  int goalId = -1;
  int diaryId = -1;

  View_Diary(int id) {
    goalId = id;
  }

  @override
  State<StatefulWidget> createState() {
    return ViewDiary(goalId);
  }
}

class ViewDiary extends State<View_Diary> {
  String content = "";
  int goalId = 0;
  int diaryId = -1;

  ViewDiary(int id) {
    this.goalId = id;
    getDiary();
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
                        Text("일기", style: TextStyle(fontSize: titleFontSize)),
                        Container(
                          height: 5,
                        ),

                        /// content
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: Color(color_whiteYellow),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.all(10),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                getMobileSizeFromPercent(context, 50, false),
                            child: SingleChildScrollView(
                                child: Text(
                              content,
                              style: TextStyle(fontSize: diaryContentFontSize),
                            )),
                          ),
                        ),
                      ],
                    ),

                    /// 수정 버튼
                    Container(
                      width: getMobileSizeFromPercent(context, 80, true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  //모서리를 둥글게
                                  borderRadius: BorderRadius.circular(16)),
                              primary: Color(color_mint),
                              onPrimary: Colors.black,
                              minimumSize: Size(getMobileSizeFromPercent(context, 35, true), getMobileSizeFromPercent(context, 6, false)),
                              //width, height
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              content == "" ? "일기쓰기" : "수정",
                              style: TextStyle(fontSize: btnTitleFontSize),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EditDiary(goalId, diaryId, content))).then((value){
                                          setState(() {
                                            getDiary();
                                          });
                            }),
                          ),

                          /// 뒤로가기 버튼
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(getMobileSizeFromPercent(context, 35, true), getMobileSizeFromPercent(context, 6, false)),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로",
                                style: TextStyle(fontSize: btnTitleFontSize),
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                    ),
                  ],
                ))),
      );

  /// 정보 얻어옴
  Future<int> getDiary() async {
    String createDiaryURI = hostURI + 'api/diary/' + goalId.toString();
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var response = await dio.get(createDiaryURI);
      setState(() {
        content = response.data['content'];
        diaryId = response.data['diaryId'];
      });

      print('====================');
      print('sucess getDiary');
      return 0;
    } catch (e) {
      print('====================');
      print('getDiary Err');
      await createDiary();
      if (await getDiary() == 0) {
        return 0;
      } else {
        Fluttertoast.showToast(
            msg:
            "정보를 받아오지 못했습니다.");
        return -1;
      }
    }
  }

  /// 일기 생성
  Future<int> createDiary() async {
    String createDiaryURI = hostURI + 'api/diary/' + goalId.toString();
    Map body = {
      'content': "",
    };
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var response = await dio.post(createDiaryURI, data: body);
      print('====================');
      print('sucess createDiary');
      return 0;
    } catch (e) {
      print('====================');
      print('createDiary Err');
      return -1;
    }
  }
}
