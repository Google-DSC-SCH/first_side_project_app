import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'dart:math';

import 'EditDaily.dart';

class AchievementRate extends StatefulWidget {
  @override
  State<AchievementRate> createState() => _AchievementRate();
}

class _AchievementRate extends State<AchievementRate> {
  String today = "";
  List<DailyObj> dailyList = [];

  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;

  // 찐노랑
  int color_realYellow = 0xFFFFD966;

  // 민트
  int color_mint = 0xFFCDF0EA;

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    today = year.toString() +
        (month < 10 ? "0" + month.toString() : month.toString()) +
        (day < 10 ? "0" + day.toString() : day.toString());

    // 랜덤으로 넣어줌
    for (int i = 0; i < 100; i++) {
      int randDay = Random().nextInt(getMaxDay(today.substring(0, 6)));
      dailyList.add(DailyObj(
          Random().nextInt(6),
          "202212" +
              (randDay < 10 ? "0" + randDay.toString() : randDay.toString()),
          (Random().nextInt(2) == 0 ? "ON" : "OFF")));
      print(dailyList[i].date);
      print(dailyList[i].status);
      print(dailyList[i].id);
    }
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
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset('assets/img/icon.png'),
                      height: getMobileSizeFromPercent(context, 10, false),
                    ),
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
                      // 날짜
                      Text("제목", style: TextStyle(fontSize: 17)),

                      // 요일_달력
                      Column(
                        children: [
                          // 요일
                          Container(
                            padding: EdgeInsets.all(3),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height: getMobileSizeFromPercent(context, 5, false),
                            child: GridView.count(
                              crossAxisCount: 7,
                              crossAxisSpacing: 5,
                              children: [
                                Text(
                                  "월",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "화",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "수",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "목",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "금",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "토",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "일",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 달력
                          Container(
                            padding: EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                            // color: Colors.yellow,
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                getMobileSizeFromPercent(context, 40, false),
                            child: GridView.builder(
                                itemCount: 30,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 3),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.blue),
                                            child: Text("aa"))),
                          )
                        ],
                      ),
                    ]))),
      );
}

// 날짜 요일 반환
String getDayOfWeek(String yearmonthday) {
  int year = int.parse(yearmonthday.substring(0, 4));
  int month = int.parse(yearmonthday.substring(4, 6));
  int day = int.parse(yearmonthday.substring(6, 8));

  // 날수
  int allDay = 0;

  // 전년도까지 날수 더함
  allDay += (year - 1) * 365 +
      (year - 1) ~/ 4 -
      (year - 1) ~/ 100 +
      (year - 1) ~/ 400;

  // 이번달 직전까지 더함
  List<int> monthDayList = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  for (int i = 0; i < month - 1; i++) {
    allDay += monthDayList[i];
  }

  // 올해가 윤년이면 1 더함
  if (month > 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
    allDay += 1;
  }

  // 오늘 날짜까지 더함
  allDay += day;

  int dayOfWeek = allDay % 7;

  switch (dayOfWeek) {
    case 0:
      return "일";
    case 1:
      return "월";
    case 2:
      return "화";
    case 3:
      return "수";
    case 4:
      return "목";
    case 5:
      return "금";
    case 6:
      return "토";
    default:
      return "에러";
  }
}

// 월 몇일까지 있나 반환
int getMaxDay(String yearmonth) {
  int year = int.parse(yearmonth.substring(0, 4));
  int month = int.parse(yearmonth.substring(4, 6));
  int maxDay = 0;

  List<int> monthDayList = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  maxDay = monthDayList[month - 1];

  // 윤년이면 + 1
  if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
    maxDay += 1;
  }

  return maxDay;
}

class DailyObj {
  int id = 0;
  String date = "";
  String status = "";
  String week = "";

  DailyObj(int id, String date, String status) {
    this.id = id;
    this.date = date;
    this.status = status;
    week = getDayOfWeek(date);
  }
}
