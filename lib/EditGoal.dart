import 'package:dio/dio.dart';
import 'package:first_side_project_app/ViewGoal.dart';
import 'package:flutter/material.dart';
import 'BaseFile.dart';

class EditGoal extends StatefulWidget {
  int goalId = -1;

  EditGoal(int id) {
    this.goalId = id;
  }

  @override
  State<EditGoal> createState() => _EditGoal(goalId);
}

class _EditGoal extends State<EditGoal> {
  int goalId = -1;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // 완료: 0, 미완료: 1
  int selectedState = 0;

  // 목표 기간
  String duoDay = "20221230";

  // 알림 여부
  String alertState = "OFF";

  // 알림 시간
  String alertTime = "13:00";
  String? selectedTime;

  _EditGoal(int id) {
    this.goalId = id;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.selectedState = 0;
    getGoal(goalId);
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
          // 외부 클릭시 키보드 숨기기
          onTap: () {
            FocusScope.of(context).unfocus();
          },

          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(
                    getMobileSizeFromPercent(context, 18, false)),
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
              body: SingleChildScrollView(
                child: Container(
                  height: getMobileSizeFromPercent(context, 82, false) -
                      MediaQuery.of(context).padding.top * 2,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 제목
                        Column(
                          children: [
                            Text("제목",
                                style: TextStyle(fontSize: titleFontSize)),
                            Container(
                              height: 5,
                            ),
                            Container(
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height:
                                    getMobileSizeFromPercent(context, 6, false),
                                child: TextField(
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
                                  controller: titleController,
                                  style: TextStyle(fontSize: 21),
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 10,
                                )),
                          ],
                        ),

                        // 설명
                        Column(
                          children: [
                            Text("설명",
                                style: TextStyle(fontSize: titleFontSize)),
                            Container(
                              height: 5,
                            ),
                            Container(
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 18, false),
                                child: TextField(
                                  // 꾸미기
                                  decoration: InputDecoration(
                                      // 색 변경
                                      filled: true,
                                      fillColor: Color(color_whiteYellow),
                                      // 둥그런 형태
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                      contentPadding: EdgeInsets.all(5)),
                                  controller: contentController,
                                  style: TextStyle(fontSize: 15),
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 20,
                                )),
                          ],
                        ),

                        // 목표 기간
                        Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("목표 기간",
                                  style: TextStyle(fontSize: titleFontSize)),
                              GestureDetector(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_whiteYellow),
                                  elevation: 0, // 그림자 깊이
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 40,
                                    child: Text(this.duoDay,
                                        style: TextStyle(fontSize: titleFontSize)),
                                  ),
                                ),
                                onTap: () {
                                  // 목표 기간 변경
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime(
                                              int.parse(
                                                duoDay.substring(0, 4),
                                              ),
                                              int.parse(
                                                duoDay.substring(5, 7),
                                              ),
                                              int.parse(
                                                duoDay.substring(8, 10),
                                              )),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2300))
                                      .then((value) {
                                    setState(() {
                                      duoDay =
                                          value.toString().substring(0, 10);
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // 알림
                        Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("알림 ",
                                  style: TextStyle(fontSize: titleFontSize)),
                              // 알림 여부
                              GestureDetector(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(alertState == "ON"
                                      ? color_realYellow
                                      : color_whiteYellow),
                                  elevation: 0, // 그림자 깊이
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 60,
                                    height: 40,
                                    child: Text(
                                      alertState,
                                      style: TextStyle(
                                          fontSize: titleFontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // 알람 상태 변경
                                  setState(() {
                                    alertState =
                                        alertState == "ON" ? "OFF" : "ON";
                                  });
                                },
                              ),
                              // 알림 시간
                              GestureDetector(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    //모서리를 둥글게 하기 위해 사용
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  color: Color(color_whiteYellow),
                                  elevation: 0, // 그림자 깊이
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 150,
                                    height: 40,
                                    child: Text(
                                      int.parse(alertTime.split(":")[0]) >= 12
                                          ? "오후 " +
                                              (alertTime.split(":")[0] == "12"
                                                      ? 12
                                                      : (int.parse(alertTime
                                                              .split(":")[0]) %
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
                                      style: TextStyle(fontSize: titleFontSize),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // 알람 상태 변경
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay(
                                              hour: int.parse(
                                                  alertTime.split(":")[0]),
                                              minute: int.parse(
                                                  alertTime.split(":")[1])))
                                      .then((value) {
                                    setState(() {
                                      alertTime =
                                          "${value!.hour}:${value!.minute}";
                                      print(alertTime);
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // 상태
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
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                            fontSize: btnTitleFontSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // 색 Switch
                                      setState(() {
                                        selectedState = 0;
                                      });
                                    },
                                  ),
                                  Container(width: 10),
                                  // 미완료 상태
                                  GestureDetector(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        //모서리를 둥글게 하기 위해 사용
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                            fontSize: btnTitleFontSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedState = 1;
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

                        // 뒤로가기
                        Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// 완료 버튼
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius: BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(
                                      getMobileSizeFromPercent(
                                          context, 30, true),
                                      40),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "완료",
                                  style: TextStyle(fontSize: btnTitleFontSize),
                                ),
                                onPressed: () async {
                                  if (await editGoal() == 0) {
                                    Navigator.pop(context);
                                  }
                                  else {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(16.0)),
                                          title: Text("오류", textAlign: TextAlign.center,),
                                          content: Text("수정을 실패했습니다.", textAlign: TextAlign.center,),
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
                                },
                              ),
                              /// 취소 버튼
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius: BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(
                                      getMobileSizeFromPercent(
                                          context, 30, true),
                                      40),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "취소",
                                  style: TextStyle(fontSize: btnTitleFontSize),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          height: 5,
                        ),
                      ]),
                ),
              )),
        ),
      );

  /// 정보 받아옴
  Future<int> getGoal(int id) async {
    print(id);
    String getDailyURI = hostURI + 'api/goal/' + goalId.toString();

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getDailyURI);
      print(res);
      setState(() {
        this.titleController.text = res.data['title'];
        this.contentController.text = res.data['content'];
        this.alertTime = res.data['alertTime'];
        this.alertState = res.data['alertStatus'];
        this.duoDay = res.data['endDate'];

        if (res.data['goalStatus'] == "ON") {
          this.selectedState = 0;
        } else {
          this.selectedState = 1;
        }
      });
      print("====================");
      print("sucess getEditGoal");
      return 0;
    } catch (e) {
      print("====================");
      print("getEditGoal Err");
    }
    return -1;
  }

  /// 수정
  Future<int> editGoal() async {
    if(titleController.text==""){
      return -1;
    }
    String editGoalURI = hostURI + 'api/goal/' + goalId.toString();
    Map body = {
      'title': titleController.text.toString(),
      'content': contentController.text.toString(),
      'alertStatus': alertState,
      'alertTime': alertTime.toString(),
      'endDate': this.duoDay,
      'goalStatus': this.selectedState == 0 ? "ON" : "OFF"
    };
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var response = await dio.put(editGoalURI, data: body);
      print('====================');
      print('sucess editGoal');
      return 0;
    } catch (e) {
      print('====================');
      print('editGoal Err');
      return -1;
    }
  }
}
