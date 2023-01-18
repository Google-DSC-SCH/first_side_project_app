import 'package:dio/dio.dart';
import 'package:first_side_project_app/CreateDaily.dart';
import 'package:first_side_project_app/SignUp.dart';
import 'package:first_side_project_app/ViewDaily.dart';
import 'package:first_side_project_app/ViewGoal.dart';
import 'package:first_side_project_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'AchievementRate.dart';
import 'CreateGoal.dart';
import 'Login.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => Real_Main();
}

class Real_Main extends State<MainPage> {
  // 정보를 가져올 날짜
  String date = "";

  // 단기목표 목록
  List<Daily> dailyList = [];

  // 장기목표 목록
  List<Goal> goalList = [];

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    date = getToday();

    setState(() {
      getMain(getToday());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("로그아웃");
    super.dispose();
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
                            width: getMobileSizeFromPercent(context, 20, true),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 오늘 날짜
                    Text(
                        date.substring(0, 4) +
                            "년 " +
                            date.substring(4, 6) +
                            "월 " +
                            date.substring(6, 8) +
                            "일",
                        style: TextStyle(fontSize: subTitleFontSize)),

                    /// 장기목표
                    Stack(
                      children: [
                        // 장기 목표 추가
                        Positioned(
                            child: GestureDetector(
                              child: Icon(Icons.add, size: addBtnIconSize),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CreateGoal())).then((value) {
                                  setState(() {
                                    getMain(getToday());
                                  });
                                });
                              },
                            ),
                            right: getMobileSizeFromPercent(context, 5, true)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("나의 목표",
                                style: TextStyle(fontSize: titleFontSize)),
                            Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Color(color_whiteYellow),
                              elevation: 0, // 그림자 깊이
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: getMobileSizeFromPercent(
                                      context, 80, true),
                                  height: getMobileSizeFromPercent(
                                      context, 25, false),
                                  child: ListView.builder(
                                    itemCount: goalList.length,
                                    itemBuilder: (context, index) => Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => ViewGoal(
                                                          goalList[index]
                                                              .goalId)))
                                              .then((value) {
                                            setState(() {
                                              getMain(getToday());
                                            });
                                          });
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: getMobileSizeFromPercent(
                                                  context, 45, true),
                                              child: Text(
                                                goalList[index].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize:
                                                        listTitleFontSize),
                                              ),
                                            ),
                                            Expanded(
                                              // width: getMobileSizeFromPercent(context, 25, true),
                                              child: Text(
                                                goalList[index].endDate,
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize:
                                                        listTitleSubFontSize),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// 단기 목표
                    Stack(
                      // 단기 목표 추가
                      children: [
                        Positioned(
                            child: GestureDetector(
                              child: Icon(Icons.add, size: addBtnIconSize),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CreateDaily())).then((value) {
                                  setState(() {
                                    getMain(getToday());
                                  });
                                });
                              },
                            ),
                            right: getMobileSizeFromPercent(context, 5, true)),
                        Column(
                          children: [
                            Text("나와의 약속",
                                style: TextStyle(fontSize: titleFontSize)),
                            Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Color(color_whiteYellow),
                              elevation: 0, // 그림자 깊이
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: getMobileSizeFromPercent(
                                      context, 80, true),
                                  height: getMobileSizeFromPercent(
                                      context, 25, false),
                                  child: ListView.builder(
                                    itemCount: dailyList.length,
                                    itemBuilder: (context, index) => Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => ViewDaily(
                                                          dailyList[index]
                                                              .dailyId)))
                                              .then((value) {
                                            setState(() {
                                              getMain(getToday());
                                            });
                                          });
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // 타이틀
                                            Container(
                                              color: Color(color_whiteYellow),
                                              width: getMobileSizeFromPercent(
                                                  context, 57, true),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dailyList[index].title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            listTitleFontSize),
                                                  ),
                                                  // 반복 요일
                                                  Text(
                                                    dailyList[index]
                                                                .alertDate ==
                                                            ""
                                                        ? "알림 요일 없음"
                                                        : dailyList[index]
                                                            .alertDate,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            listTitleSubFontSize),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // 상태
                                            Container(
                                              width: getMobileSizeFromPercent(
                                                  context, 13, true),
                                              child: Switch(
                                                value:
                                                    dailyList[index].statue ==
                                                        "ON",
                                                onChanged: (value) async {
                                                  if (await patchDailyState(
                                                          dailyList[index]
                                                              .dailyId,
                                                          dailyList[index]
                                                              .statue) ==
                                                      0) {
                                                    // 달성
                                                    if (value) {
                                                      setState(() {
                                                        dailyList[index]
                                                            .statue = "ON";
                                                      });
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0)),
                                                                    title: Text(
                                                                      dailyList[
                                                                              index]
                                                                          .title,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    content:
                                                                        Text(
                                                                      "목표를 완료했습니다!",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      new TextButton(
                                                                        child: new Text(
                                                                            "확인"),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ));
                                                    }
                                                    // 미달성
                                                    else {
                                                      setState(() {
                                                        dailyList[index]
                                                            .statue = "OFF";
                                                      });
                                                    }
                                                  }
                                                },
                                                activeColor: Color(0xFFB1AFFF),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // 달성률 페이지
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    // 달성률 페이지로 이동
                                    builder: (_) =>
                                        AchievementRate(dailyList.length)))
                            .then((value) {
                          setState(() {
                            getMain(getToday());
                          });
                        });
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
                            width: getMobileSizeFromPercent(context, 50, true),
                            height: getMobileSizeFromPercent(context, 6, false),
                            child: Text(
                              "달성률 보기",
                              style: TextStyle(
                                fontSize: btnTitleFontSize,
                              ),
                            )),
                      ),
                    ),

                    Container(
                      height: 5,
                    ),
                  ],
                ))),
      );

  /// main 정보 받아옴
  Future<int> getMain(String today) async {
    String getMainURI = hostURI + 'api/main/';
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getMainURI);

      // 모든 알림 제거
      cancelNotification();

      // 모든 리스트 초기화
      goalList.clear();
      dailyList.clear();

      // // goal List 추가
      for (Map goal in res.data['goalResponseList']['goal']) {
        setState(() {
          if (goal['goal_status'] == "OFF") {
            goalList
                .add(Goal(goal['title'], goal['end_date'], goal['goal_id']));
            // goal 알림 추가
            if (goal['alert_status'] == "ON") {
              List ls = goal['alert_time'].split(':');
              registerMessage(
                  notificationId: goal['goal_id'] * -1,
                  year: DateTime.now().year,
                  month: DateTime.now().month,
                  day: DateTime.now().day,
                  hour: int.parse(ls[0]),
                  minutes: int.parse(
                    ls[1],
                  ),
                  message: goal['title'],
                  target: "goal");
              print('addAlert: ' + DateTime.now().toString());
            }
          }
        });
      }

      // 이번주 첫날 마지막날
      var now = DateTime.now();

      // daily List 추가
      for (Map daily in res.data['dailyResponseList']['daily']) {
        setState(() {
          dailyList.add(Daily(daily['title'], daily['daily_id'],
              daily['alert_dates'], daily['daily_status']));
        });

        print(daily);
        // daily 알림 추가
        if (daily['alert_status'] == "ON" && daily['daily_status'] == "OFF") {
          for (String day in daily['alert_dates'].split('')) {
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
            print(daily['alert_time']);
            List ls = daily['alert_time'].split(':');
            registerMessage(
                notificationId: daily['daily_id'] * 7 + addNum,
                year: firstTime.year,
                month: firstTime.month,
                day: firstTime.day,
                hour: int.parse(ls[0]),
                minutes: int.parse(
                  ls[1],
                ),
                message: daily['title'],
                target: "daily");
            print('addAlert: ' + firstTime.toString());
          }
        }
      }

      print("====================");
      print('sucess getMainData');
      return 0;
    } catch (e) {
      print("====================");
      print("getMainDataErr");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(
                  "오류",
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  "정보를 받아오지 못했습니다.",
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
    return -1;
  }

  /// 단기목표 상태 변경
  Future<int> patchDailyState(int dailyId, String changeState) async {
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
    body = {'dailyStatusChange': changeState == "ON" ? "OFF" : "ON"};

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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(
                  "오류",
                  textAlign: TextAlign.center,
                ),
                content: Text(
                  "정보 전송을 실패했습니다.",
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
    return -1;
  }
}

/// 장기목표
class Goal {
  String title = '';
  String endDate = '';
  int goalId = -1;

  Goal(String title, String endDate, id) {
    this.title = title;
    this.endDate = endDate;
    this.goalId = id;
  }
}

/// 단기목표
class Daily {
  String title = '';
  int dailyId = -1;
  String alertDate = '';
  String statue = '';

  Daily(String title, int id, String alertDate, String status) {
    this.title = title;
    this.dailyId = id;
    this.alertDate = alertDate;
    this.statue = status;
  }
}
