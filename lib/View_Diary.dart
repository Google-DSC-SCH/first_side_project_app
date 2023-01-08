import 'package:dio/dio.dart';
import 'package:first_side_project_app/Achieved_Goal.dart';
import 'package:first_side_project_app/EditDiary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'MainPage.dart';

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
    getDiary().then((value){
      if(value != 0){
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16.0)),
              title: Text("오류", textAlign: TextAlign.center,),
              content: Text("정보를 받아오지 못했습니다.", textAlign: TextAlign.center,),
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
    });
  }

  // 위젯간 간격(세로)
  double titleFontSize = 17;

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
                              style: TextStyle(fontSize: 30),
                            )),
                          ),
                        ),
                      ],
                    ),

                    /// 수정 버튼
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
                              minimumSize: Size(130, 40),
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
                                        EditDiary(goalId, diaryId, content))),
                          ),

                          /// 뒤로가기 버튼
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(130, 40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로",
                                style: TextStyle(fontSize: 20),
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
      await getDiary();
      return -1;
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
