import 'package:dio/dio.dart';
import 'package:first_side_project_app/View_Diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BaseFile.dart';
import 'MainPage.dart';

class EditDiary extends StatelessWidget {
  TextEditingController contentController = TextEditingController();

  int goalId = -1;
  int diaryId = -1;
  String firstContent = "";

  EditDiary(int id, int diaryId, String content) {
    this.goalId = id;
    this.diaryId = diaryId;
    contentController.text = content;
    firstContent = content;
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("일기 작성",
                              style: TextStyle(fontSize: titleFontSize)),
                          Container(
                            height: 5,
                          ),
                          SingleChildScrollView(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Color(color_whiteYellow),
                              elevation: 0, // 그림자 깊이
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: getMobileSizeFromPercent(
                                      context, 80, true),
                                  height: getMobileSizeFromPercent(
                                      context, 50, false),
                                  child: TextField(
                                    controller: contentController,
                                    // 꾸미기
                                    decoration: InputDecoration(
                                        // 색 변경
                                        filled: true,
                                        fillColor: Color(color_whiteYellow),
                                        // 둘그런 형태
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                        ),
                                        contentPadding: EdgeInsets.all(5)),
                                    style: TextStyle(fontSize: 21),
                                    textAlignVertical: TextAlignVertical.center,
                                    maxLines: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// 완료 버튼
                              GestureDetector(
                                onTap: () async {
                                  if (await editDiary() == 0) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg:
                                        firstContent == "" ? "일기를 등록했습니다." : "일기를 수정했습니다.");
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                        "등록을 실패했습니다.");
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_mint),
                                  elevation: 0, // 그림자 깊이
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      width: getMobileSizeFromPercent(
                                          context, 35, true),
                                      height: getMobileSizeFromPercent(
                                          context, 6, false),
                                      child: Text(
                                        "완료",
                                        style: TextStyle(
                                          fontSize: btnTitleFontSize,
                                        ),
                                      )),
                                ),
                              ),

                              /// 취소 버튼
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_mint),
                                  elevation: 0, // 그림자 깊이
                                  child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(5),
                                      width: getMobileSizeFromPercent(
                                          context, 35, true),
                                      height: getMobileSizeFromPercent(
                                          context, 6, false),
                                      child: Text(
                                        "취소",
                                        style: TextStyle(
                                          fontSize: btnTitleFontSize,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ))),
        ),
      );

  /// 일기 수정
  Future<int> editDiary() async {
    String editDiaryURI = hostURI + 'api/diary/' + diaryId.toString();
    Map body = {
      'content': contentController.text.toString(),
    };
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    print(editDiaryURI);
    print(body);
    try {
      var response = await dio.put(editDiaryURI, data: body);
      print('====================');
      print('sucess editDiary');
      return 0;
    } catch (e) {
      print('====================');
      print('editDiary Err');
      return -1;
    }
  }
}
