import 'package:dio/dio.dart';
import 'package:first_side_project_app/View_Diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'MainPage.dart';

class AchievedGoal extends StatefulWidget{
  @override
  State<AchievedGoal> createState()=>_AchievedGoal();
}

class _AchievedGoal extends State<AchievedGoal> {
  // 위젯간 간격(세로)
  double titleFontSize = 17;

  List goalList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAchievedGoal();
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
                        Text("달성한 목표들",
                            style: TextStyle(fontSize: titleFontSize)),
                        Container(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: Color(color_whiteYellow),
                          elevation: 0, // 그림자 깊이
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                getMobileSizeFromPercent(context, 50, false),
                            child: ListView.builder(
                              itemCount: goalList.length,
                              padding: EdgeInsets.all(10),
                              itemBuilder: (context, index) => Card(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => View_Diary()));
                                  },
                                  child: Text(
                                    goalList[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                                color: Color(color_whiteYellow),
                                margin: EdgeInsets.all(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        //모서리를 둥글게 하기 위해 사용
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      color: Color(color_mint),
                      elevation: 0, // 그림자 깊이
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            width: getMobileSizeFromPercent(context, 50, true),
                            height: getMobileSizeFromPercent(context, 6, false),
                            child: Text(
                              "뒤로 가기",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            )),
                      ),
                    ),
                  ],
                ))),
      );

  /// 정보 받아옴
  Future<int> getAchievedGoal() async {
    String getURI = hostURI +
        'api/users/goals';

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getURI);
      for(Map goal in res.data["goalResList"]){
        setState(() {
          goalList.add(Goal(goal['goalId'], goal['title']));
        });
        print(goal);
      }

      print("====================");
      print("sucess getAchievedGoal");
      return 0;
    } catch (e) {
      print("====================");
      print("getAchievedGoal Err");
    }
    return -1;
  }
}

class Goal{
  int goalId = 0;
  String title = "";

  Goal(int id, String title){
    this.goalId = id;
    this.title = title;
  }
}