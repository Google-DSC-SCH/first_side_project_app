import 'package:first_side_project_app/CreateDaily.dart';
import 'package:first_side_project_app/ViewDaily.dart';
import 'package:first_side_project_app/ViewGoal.dart';
import 'package:first_side_project_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';
import 'AchievementRate.dart';


class MainPage extends StatefulWidget{
  @override
  State<MainPage> createState()=>Real_Main();
}

class Real_Main extends State<MainPage> {
  // 정보를 가져올 날짜
  String date = "";
  // 단기목표 목록
  List<Daily> dailyList = [];
  // 장기목표 목록
  List<Goal> goalList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = getToday();
    
    dailyList.add(Daily('토익 850점 넘기'));
    dailyList.add(Daily('데이터베이스 자격증 부시기'));

    goalList.add(Goal('토익 850점 넘기'));
    goalList.add(Goal('데이터베이스 자격증 부시기'));
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
            // floatingActionButton: FloatingActionButton(
            //   onPressed: (() => main()),
            //   child: Icon(Icons.arrow_circle_left),
            // ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Stack(
              children: <Widget>[
                Positioned(
                  left: 10,
                  top: getMobileSizeFromPercent(context, 56, false),
                  child: SizedBox(
                    width: 48,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_left, size: 38),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: getMobileSizeFromPercent(context, 56, false),
                  child: SizedBox(
                    width: 48,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_right, size: 38),
                    ),
                  ),
                ),
                Positioned(
                  right: 42,
                  top: getMobileSizeFromPercent(context, 62, false),
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
                            date.substring(0,4) + "년 " + date.substring(4,6)+ "월 " + date.substring(6,8) + "일",
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
                              height: getMobileSizeFromPercent(
                                  context, 25, false),
                              child: ListView.builder(
                                itemCount: goalList.length,
                                itemBuilder: (context, index)=> Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ViewGoal()));
                                    },
                                    child: Text(
                                      goalList[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: listTitleFontSize),
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
                              height: getMobileSizeFromPercent(
                                  context, 25, false),
                              child: ListView.builder(
                                itemCount: dailyList.length,
                                itemBuilder: (context, index)=> Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ViewDaily()));
                                      },
                                      child: Text(
                                        dailyList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: listTitleFontSize),
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
                                  builder: (_) => AchievementRate()));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            width:
                                getMobileSizeFromPercent(context, 50, true),
                            height:
                                getMobileSizeFromPercent(context, 6, false),
                            child: Text(
                              "달성률 보기",
                              style: TextStyle(
                                fontSize: btnTitleFontSize,
                              ),
                            )),
                      ),
                    ),
                  ],
                ))),
      );
}

/// 단기목표
class Daily{
  String title = '';

  Daily(String title){
    this.title = title;
  }
}

class Goal{
  String title = '';

  Goal(String title){
    this.title = title;
  }
}