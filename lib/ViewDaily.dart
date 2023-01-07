import 'package:dio/dio.dart';
import 'package:first_side_project_app/MainPage.dart';
import 'package:flutter/material.dart';
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
  String alertTime = "13:10";

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
    this.alertTime = "";
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
                                        style: TextStyle(fontSize: 21),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 설명
                      Column(
                        children: [
                          Text("설명", style: TextStyle(fontSize: titleFontSize)),
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
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),

                      // 반복 요일
                      Container(
                        width: getMobileSizeFromPercent(context, 65, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("반복요일",
                                style: TextStyle(fontSize: titleFontSize)),
                            Text(
                              this.repeatDay,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            )
                          ],
                        ),
                      ),

                      // 알림
                      Container(
                        width: getMobileSizeFromPercent(context, 65, true),
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(
                              this.alertTime,
                              // int.parse(alertTime.split(":")[0]) >= 12
                              //     ? "오후 " +
                              //     (alertTime.split(":")[0] == "12"
                              //         ? 12
                              //         : (int.parse(
                              //         alertTime.split(":")[0]) %
                              //         12))
                              //         .toString() +
                              //     "시 " +
                              //     alertTime.split(":")[1] +
                              //     "분"
                              //     : "오전 " +
                              //     alertTime.split(":")[0] +
                              //     "시 " +
                              //     alertTime.split(":")[1] +
                              //     "분",
                              style: TextStyle(
                                fontSize: 25,
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
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    // 색 Switch
                                    setState(() {
                                      selectedState = 0;
                                      patchDailyState(0);
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
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedState = 1;
                                      patchDailyState(1);
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 수정
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(80, 40),
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
                                          EditDaily(dailyId))),
                            ),
                            // /
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(80, 40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "삭제",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if(await deleteDaily() == 0){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()));
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
                                minimumSize: Size(80, 40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
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
  Future<int> getDaily(int id) async {
    String getDailyURI = hostURI +
        'api/daily/' +
        dailyId.toString() +
        "/" +
        DateTime.now().year.toString() +
        "-" +
        getToday().substring(4, 6) +
        "-" +
        getToday().substring(6,8);

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
      print("====================");
      print("sucess getDaily");
    } catch (e) {
      print("====================");
      print("getDaily Err");
      await createDailyStatus(id);
      await getDaily(id);
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
        getToday().substring(6,8);

    Map body = {'dailyStatus' : 'OFF'};

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
        getToday().substring(6,8) +
        '/status';

    late Map body;
    if (changeState == 0) {
      body = {'dailyStatusChange': 'ON'};
    } else {
      body = {'dailyStatusChange': 'OFF'};
    }
    print(patchDailyURI);

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res =
          await dio.patch(patchDailyURI, data: body);
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
    String deleteDaily = hostURI +
        'api/daily/' +
        dailyId.toString();

    print(deleteDaily);

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res =
          await dio.delete(deleteDaily);
      print('success deleteDaily');
      return 0;
    } catch (e) {
      print("====================");
      print('deleteDailyErr');
    }
    return -1;
  }
}
