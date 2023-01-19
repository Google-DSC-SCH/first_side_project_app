import 'package:dio/dio.dart';
import 'package:first_side_project_app/MainPage.dart';
import 'package:first_side_project_app/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'BaseFile.dart';

import 'EditDaily.dart';

class ViewDaily extends StatefulWidget {
  int id = -1;

  ViewDaily(int id) {
    this.id = id;
  }

  @override
  State<ViewDaily> createState() => _ViewDaily(id);
}

class _ViewDaily extends State<ViewDaily> {
  int dailyId = -1;

  String title = "";
  String content = "";
  String repeatDay = "";
  String alarmOnOff = "";
  String alertTime = "";

  // 완료 여부, 0: 완료, 1:미완료
  int selectedState = 0;

  // 위젯간 간격(세로)
  double titleFontSize = 17;

  // id 받아옴
  _ViewDaily(int id) {
    this.dailyId = id;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.title = "";
    this.content = "";
    this.repeatDay = "";
    this.alarmOnOff = "";
    this.alertTime = "9:0";
    this.selectedState = 0;

    // 서버에서 데이터를 받아옴
    getDaily(dailyId);
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
                            Text("알림 반복 요일",
                                style: TextStyle(fontSize: titleFontSize)),
                            Text(
                              this.repeatDay == ""
                                  ? "알림 반복 없음"
                                  : this.repeatDay,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: viewDailyDateFontSize,),
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
                                  onTap: () {
                                    // 색 Switch
                                    setState(() {
                                      selectedState = 0;
                                      patchDailyState(0).then((value) {
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
                                  onTap: () {
                                    setState(() {
                                      selectedState = 1;
                                      patchDailyState(1).then((value) {
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

                      Container(
                        height: 10,
                      ),

                      /// 뒤로가기
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // 수정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
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
                                          EditDaily(dailyId))).then((value) {
                                setState(() {
                                  getDaily(dailyId);
                                });
                              }),
                            ),
                            // /
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "삭제",
                                style: TextStyle(fontSize: btnTitleFontSize),
                              ),
                              onPressed: () async {
                                if (await deleteDaily() == 0) {
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                      msg:
                                      "${title}을(를) 삭제했습니다.");
                                }
                              },
                            ),
                            // 뒤로
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius: BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(getMobileSizeFromPercent(context, 23, true), getMobileSizeFromPercent(context, 6, false)),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "뒤로",
                                  style: TextStyle(fontSize: btnTitleFontSize),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),

                      Container(
                        height: 5,
                      ),
                    ]))),
      );

  /// 정보 받아옴
  Future<int> getDaily(int id) async {
    String getDailyURI = hostURI +
        'api/daily/' +
        dailyId.toString() +
        "/" +
        DateTime.now().year.toString() +
        "-" +
        getToday().substring(4, 6) +
        "-" +
        getToday().substring(6, 8);

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getDailyURI);
      setState(() {
        this.title = res.data['title'];
        this.repeatDay = res.data['alertDates'];
        this.content = res.data['content'];
        this.alertTime = res.data['alertTime'];
        this.alarmOnOff = res.data['alertStatus'];
        if (res.data['dailyStatus'] == "ON") {
          this.selectedState = 0;
        } else {
          this.selectedState = 1;
        }
      });

      // 알림 초기화
      for (int i = 0; i < 7; i++) {
        cancelNotificationSpecific(dailyId * 7 + i);
        print('cancleAlert');
      }

      //알림 추가
      var now = DateTime.now();
      if (alarmOnOff == "ON" &&
          selectedState == 1) {
        for (String day in repeatDay.split('')) {
          var firstTime =
              DateTime(now.year, now.month, now.day - (now.weekday - 1));
          int addNum = 0;
          switch (day) {
            case "월":
              firstTime =
                  DateTime(now.year, now.month, now.day - (now.weekday - 1));
              break;
            case "화":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 1);
              addNum = 1;
              break;
            case "수":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 2);
              addNum = 2;
              break;
            case "목":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 3);
              addNum = 3;
              break;
            case "금":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 4);
              addNum = 4;
              break;
            case "토":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 5);
              addNum = 5;
              break;
            case "일":
              firstTime = DateTime(
                  now.year, now.month, now.day - (now.weekday - 1) + 6);
              addNum = 6;
              break;
          }
          List ls = alertTime.split(':');
          registerMessage(
              notificationId: dailyId * 7 + addNum,
              year: firstTime.year,
              month: firstTime.month,
              day: firstTime.day,
              hour: int.parse(ls[0]),
              minutes: int.parse(
                ls[1],
              ),
              message: title,
              target: "daily");
          print('addAlert: ' + firstTime.toString());
        }
      }

      print("====================");
      print("sucess getDaily");
      print(alertTime);
      return 0;
    } catch (e) {
      print("====================");
      print("getDaily Err");
      Fluttertoast.showToast(
          msg:
          "정보를 받아오지 못했습니다.");
    }
    return -1;
  }

  /// status 생성
  Future<int> createDailyStatus(int id) async {
    String getDailyURI = hostURI +
        'api/daily/' +
        dailyId.toString() +
        "/" +
        DateTime.now().year.toString() +
        "-" +
        getToday().substring(4, 6) +
        "-" +
        getToday().substring(6, 8);

    Map body = {'dailyStatus': 'OFF'};

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.post(getDailyURI, data: body);

      print("====================");
      print("sucess createDailyDates");
    } catch (e) {
      print("====================");
      print("createDailyDates Err");
    }
    return -1;
  }

  /// 상태 변경
  Future<int> patchDailyState(int changeState) async {
    String patchDailyURI = hostURI +
        'api/daily/' +
        dailyId.toString() +
        "/" +
        DateTime.now().year.toString() +
        "-" +
        getToday().substring(4, 6) +
        "-" +
        getToday().substring(6, 8) +
        '/status';

    late Map body;
    if (changeState == 0) {
      body = {'dailyStatusChange': 'ON'};
    } else {
      body = {'dailyStatusChange': 'OFF'};
    }

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.patch(patchDailyURI, data: body);
      print("====================");
      print('success patchDailyState');
      return 0;
    } catch (e) {
      print("====================");
      print('fetchDailyStatusErr');
    }
    return -1;
  }

  /// 삭제
  Future<int> deleteDaily() async {
    String deleteDaily = hostURI + 'api/daily/' + dailyId.toString();

    print(deleteDaily);

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.delete(deleteDaily);
      print('success deleteDaily');
      return 0;
    } catch (e) {
      print("====================");
      print('deleteDailyErr');
    }
    return -1;
  }
}
