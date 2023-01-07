import 'package:dio/dio.dart';
import 'package:first_side_project_app/CreateDaily.dart';
import 'package:first_side_project_app/ViewDaily.dart';
import 'package:first_side_project_app/ViewGoal.dart';
import 'package:first_side_project_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'AchievementRate.dart';
import 'CreateGoal.dart';

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

    goalList.add(Goal('test fdfdfdf dfdfdfd fdfdfdf', '2023-02-23', 11));
    dailyList.add(Daily('test afsdf  dfas ssd sdf', 2, '월화수목금토일', "ON"));

    setState(() {
      // getMain(getToday());
    });
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
                    Container()
                  ],
                ),
              ),
            ),

            /// +버튼
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Stack(
              children: <Widget>[
                /// Daily 추가
                Positioned(
                  right: 50,
                  top: getMobileSizeFromPercent(context, 56, false),
                  child: SizedBox(
                    width: 48,
                    child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CreateDaily())),
                      icon: Icon(Icons.add),
                      iconSize: 35,
                    ),
                  ),
                ),

                /// Goal 추가
                Positioned(
                  right: 50,
                  top: getMobileSizeFromPercent(context, 26, false),
                  child: SizedBox(
                    width: 48,
                    child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => CreateGoal())),
                      icon: Icon(Icons.add),
                      iconSize: 35,
                    ),
                  ),
                ),
              ],
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
                    /// 장기목표
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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

                        Text("\n아자아자 나의 목표",
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
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 25, false),
                              child: ListView.builder(
                                itemCount: goalList.length,
                                itemBuilder: (context, index) => Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ViewGoal(11)));
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
                                                fontSize: listTitleFontSize),
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
                                                    listTitleFontSize - 5),
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

                    /// 단기 목표
                    Column(
                      children: [
                        Text("오늘 하루 나와의 약속",
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
                              width:
                                  getMobileSizeFromPercent(context, 80, true),
                              height:
                                  getMobileSizeFromPercent(context, 25, false),
                              child: ListView.builder(
                                itemCount: dailyList.length,
                                itemBuilder: (context, index) => Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ViewDaily(
                                                  dailyList[index].dailyId)));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 타이틀
                                        Expanded(
                                          // color:Colors.red,
                                          // width: getMobileSizeFromPercent(context, 35, true),
                                          child: Text(
                                            dailyList[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: listTitleFontSize),
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        // 요일, 상태
                                        Row(
                                          children: [
                                            Text(
                                              dailyList[index].alertDate,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize:
                                                      listTitleFontSize - 5),
                                            ),
                                            Switch(
                                              value: dailyList[index].statue ==
                                                  "ON",
                                              onChanged: (value) {
                                                print(value);
                                                if (value) {
                                                  setState(() {
                                                    dailyList[index].statue =
                                                        "ON";
                                                  });
                                                } else {
                                                  setState(() {
                                                    dailyList[index].statue =
                                                        "OFF";
                                                  });
                                                }
                                              },
                                              activeColor: Color(0xFFB1AFFF),
                                            )
                                          ],
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

                    // 로그인 버튼
                    Card(
                      shape: RoundedRectangleBorder(
                        //모서리를 둥글게 하기 위해 사용
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: Color(color_mint),
                      elevation: 0, // 그림자 깊이
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // 달성률 펭지로 이동
                                  builder: (_) =>
                                      AchievementRate(dailyList.length)));
                        },
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
  Future<void> getMain(String today) async {
    String getMainURI =
        hostURI + 'api/main/' + today.substring(0, 4) + '-' + '02';
    print(getMainURI);
    // '-02';
    // +DateTime.now().month.toString();
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getMainURI);

      // goal List 추가
      List<dynamic> keyList = res.data['goalResponseList'].keys.toList();
      keyList.sort();
      print(res.data['goalResponseList']);
      for (var key in keyList) {
        for (var goal in res.data['goalResponseList'][key]) {
          bool canRegi = true;
          // 기존 항목에 같은 객체 있나 검사
          print(goal);
        }
      }

      // daily List 추가
      // for (var i in res.data['dailyResponseList']['daily']) {
      //   bool canRegi = true;
      //   // 기존 항목에 같은 객체 있나 검사
      //   for (var j in dailyList){
      //     if (i['daily_id'] == j.dailyId){
      //       canRegi = false;
      //     }
      //   }
      //   if(canRegi){
      //   setState(() {
      //       dailyList.add(Daily(i['title'], i['daily_id']));
      //     });
      //   }
      // }
      print("====================");
      print('sucess getMainData');
    } catch (e) {
      print("====================");
      print("getMainDataErr");
    }
  }
}

/// 단기목표
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
