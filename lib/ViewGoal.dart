import 'package:dio/dio.dart';
import 'package:first_side_project_app/MainPage.dart';
import 'package:first_side_project_app/View_Diary.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BaseFile.dart';

import 'EditDaily.dart';
import 'EditGoal.dart';
import 'main.dart';

class ViewGoal extends StatefulWidget {
  int goalId = 0;

  ViewGoal(int id) {
    this.goalId = id;
  }

  @override
  State<ViewGoal> createState() => _ViewGoal(goalId);
}

class _ViewGoal extends State<ViewGoal> {
  int goalId = -1;
  String title = "";
  String content = "";
  String duoDay = "";
  String alarmOnOff = "";
  String alertTime = "9:0";

  // 완료 여부, 0: 완료, 1:미완료
  int selectedState = 0;

  _ViewGoal(int id) {
    this.goalId = id;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGoal(goalId);

    // 서버에서 데이터를 받아옴
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
                          Text(
                            DateTime.now().year.toString() +
                                "년 " +
                                DateTime.now().month.toString() +
                                "월 " +
                                DateTime.now().day.toString() +
                                "일 ",
                            style: TextStyle(fontSize: logoDateFontSize),
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MainPage()),
                            (route) => false);
                      },
                    ),
                    Container(
                      height: getMobileSizeFromPercent(context, 7, false),
                    )
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
                          Text("제목", style: TextStyle(fontSize: titleFontSize)),
                          Container(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게 하기 위해 사용
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(color_whiteYellow),
                            elevation: 0, // 그림자 깊이
                            child: Container(
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height:
                                    getMobileSizeFromPercent(context, 6, false),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        this.title,
                                        style: TextStyle(
                                            fontSize: viewTitleFontSize),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 메모
                      Column(
                        children: [
                          Text("메모", style: TextStyle(fontSize: titleFontSize)),
                          Container(
                            height: 5,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              //모서리를 둥글게 하기 위해 사용
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Color(color_whiteYellow),
                            elevation: 0, // 그림자 깊이
                            child: Container(
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 18, false),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        this.content,
                                        style: TextStyle(
                                            fontSize: viewContentFontSize),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 반복 요일
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("목표기간",
                                style: TextStyle(fontSize: titleFontSize)),
                            Text(
                              this.duoDay,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: duoDayFontSize),
                            )
                          ],
                        ),
                      ),

                      // 알림
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("알림 ",
                                    style: TextStyle(fontSize: titleFontSize)),
                                Container(
                                  width: 10,
                                ),
                                Text(this.alarmOnOff,
                                    style: TextStyle(
                                        fontSize: alertStateFontSize,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(
                              int.parse(alertTime.split(":")[0]) >= 12
                                  ? "오후 " +
                                      (alertTime.split(":")[0] == "12"
                                              ? 12
                                              : (int.parse(
                                                      alertTime.split(":")[0]) %
                                                  12))
                                          .toString() +
                                      "시 " +
                                      alertTime.split(":")[1] +
                                      "분"
                                  : "오전 " +
                                      alertTime.split(":")[0] +
                                      "시 " +
                                      alertTime.split(":")[1] +
                                      "분",
                              style: TextStyle(
                                fontSize: alertTimeFontSize,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),

                      /// 상태
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("상태",
                                style: TextStyle(fontSize: titleFontSize)),
                            Row(
                              children: [
                                // 완료 상태
                                GestureDetector(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(selectedState == 0
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      height: 40,
                                      child: Text(
                                        "완료",
                                        style: TextStyle(
                                          fontSize: goalStateFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    // 색 Switch
                                    setState(() {
                                      selectedState = 0;
                                      patchGoalState(selectedState)
                                          .then((value) {
                                        if (value != 0) {
                                          Fluttertoast.showToast(
                                              msg:
                                              "상태 변경을 실패했습니다.");
                                        }
                                        else{
                                          Fluttertoast.showToast(
                                              msg:
                                              "${title}! 성공을 축하드려요!");
                                        }
                                      });
                                    });
                                  },
                                ),
                                Container(width: 10),
                                // 미완료 상태
                                GestureDetector(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    color: Color(selectedState == 1
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      height: 40,
                                      child: Text(
                                        "미완료",
                                        style: TextStyle(
                                          fontSize: goalStateFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      selectedState = 1;
                                      patchGoalState(selectedState)
                                          .then((value) {
                                        if (value != 0) {
                                          Fluttertoast.showToast(
                                              msg:
                                              "상태 변경을 실패했습니다.");
                                        }
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      if(selectedState == 1)
                        Container(
                          height: getMobileSizeFromPercent(context, 6, false),
                        ),

                      // 일기 페이지 이동
                      if (selectedState == 0)
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              primary: Color(color_mint),
                              onPrimary: Colors.black,
                              minimumSize: Size(getMobileSizeFromPercent(context, 75, true), getMobileSizeFromPercent(context, 6, false)),
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Text(
                              "일기",
                              style:
                              TextStyle(fontSize: btnTitleFontSize),
                            ),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        View_Diary(goalId))),
                          ),
                        ),

                      // 하단 버튼
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            
                            // 수정 버튼
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize:
                                    Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
                                //width, height
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "수정",
                                style: TextStyle(fontSize: btnTitleFontSize),
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditGoal(goalId))).then((value) {
                                setState(() {
                                  getGoal(goalId);
                                });
                              }),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize:
                                    Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "삭제",
                                style: TextStyle(fontSize: btnTitleFontSize),
                              ),
                              onPressed: () async {
                                if (await deleteGoal() == 0) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg:
                                      "${title}을(를) 삭제했습니다.");
                                }
                              },
                            ),

                            // 뒤로가기 버튼
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize:
                                    Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로",
                                style: TextStyle(fontSize: btnTitleFontSize),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 5,
                      ),
                    ]))),
      );

  /// 정보 받아옴
  Future<int> getGoal(int id) async {
    String getDailyURI = hostURI + 'api/goal/' + goalId.toString();

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getDailyURI);
      setState(() {
        this.title = res.data['title'];
        this.content = res.data['content'];
        this.alertTime = res.data['alertTime'];
        this.alarmOnOff = res.data['alertStatus'];
        this.duoDay = res.data['endDate'];

        if (res.data['goalStatus'] == "ON") {
          this.selectedState = 0;
        } else {
          this.selectedState = 1;
        }
      });

      // 알림 제거
      cancelNotificationSpecific(goalId * -1);
      print("cancle alert");

      // 알림 추가
      if (alarmOnOff == "ON") {
        List ls = alertTime.split(':');
        registerMessage(
            notificationId: goalId * -1,
            year: DateTime.now().year,
            month: DateTime.now().month,
            day: DateTime.now().day,
            hour: int.parse(ls[0]),
            minutes: int.parse(
              ls[1],
            ),
            message: title,
            target: "goal");
        print('addAlert: ' + DateTime.now().toString());
      }
      print("====================");
      print("sucess getViewGoal");
      return 0;
    } catch (e) {
      print("====================");
      print("getViewGoal Err");
      Fluttertoast.showToast(
          msg:
          "정보를 받아오지 못했습니다.");
    }
    return -1;
  }

  /// 상태 변경
  Future<int> patchGoalState(int changeState) async {
    String patchDailyURI =
        hostURI + 'api/goal/' + goalId.toString() + '/status';

    late Map body;
    if (changeState == 0) {
      body = {'goalStatusChange': 'ON'};
    } else {
      body = {'goalStatusChange': 'OFF'};
    }

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.patch(patchDailyURI, data: body);
      print("====================");
      print('success patchGoalState');
      return 0;
    } catch (e) {
      print("====================");
      print('patchGoalState');
    }
    return -1;
  }

  /// 삭제
  Future<int> deleteGoal() async {
    String deleteGoal = hostURI + 'api/goal/' + goalId.toString();

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.delete(deleteGoal);
      print("====================");
      print('success deleteGoal');
      return 0;
    } catch (e) {
      print("====================");
      print('deleteGoal Err');
    }
    return -1;
  }
}
