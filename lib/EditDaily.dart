import 'package:dio/dio.dart';
import 'package:first_side_project_app/ViewDaily.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BaseFile.dart';
import 'MainPage.dart';

class EditDaily extends StatefulWidget {
  int dailyId = -1;

  EditDaily(int id) {
    this.dailyId = id;
  }

  @override
  State<EditDaily> createState() => _EditDaily(dailyId);
}

class _EditDaily extends State<EditDaily> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // dailyID
  int dayilyId = -1;

  // 요일 상테 텍스트
  String checkedDayStr = "";

  // 요일 상태
  List<bool> checkedDayList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  // 알림 여부
  String alertState = "OFF";

  // 알림 시간
  String alertTime = "13:00";

  _EditDaily(int id) {
    this.dayilyId = id;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 제목
    titleController.text = "";

    // 메모
    contentController.text = "";

    // 요일 상태 리스트 업데이트
    checkedDayStr = "";

    getDailyEdit(dayilyId);
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
                              width:
                                  getMobileSizeFromPercent(context, 10, false),
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
                                  builder: (BuildContext context) =>
                                      MainPage()),
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

                        // 메모
                        Column(
                          children: [
                            Text("메모",
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
                                      // 둘그런 형태
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

                        // 반복 요일
                        Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("알림 반복 요일",
                                  style: TextStyle(fontSize: titleFontSize)),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 월
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[0]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "월",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[0] =
                                          checkedDayList[0] ? false : true;
                                        });
                                      },
                                    ),

                                    // 화
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[1]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "화",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[1] =
                                          checkedDayList[1] ? false : true;
                                        });
                                      },
                                    ),

                                    // 수
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[2]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "수",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[2] =
                                          checkedDayList[2] ? false : true;
                                        });
                                      },
                                    ),

                                    // 목
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[3]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "목",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[3] =
                                          checkedDayList[3] ? false : true;
                                        });
                                      },
                                    ),

                                    // 금
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[4]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "금",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[4] =
                                          checkedDayList[4] ? false : true;
                                        });
                                      },
                                    ),

                                    // 토
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[5]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "토",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[5] =
                                          checkedDayList[5] ? false : true;
                                        });
                                      },
                                    ),

                                    // 일
                                    GestureDetector(
                                      child: Card(
                                        margin: EdgeInsets.only(top:5),
                                        shape: RoundedRectangleBorder(
                                          //모서리를 둥글게 하기 위해 사용
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        color: Color(checkedDayList[6]
                                            ? color_realYellow
                                            : color_whiteYellow),
                                        elevation: 0, // 그림자 깊이
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: getMobileSizeFromPercent(
                                                context, 10, true),
                                            height: getMobileSizeFromPercent(
                                                context, 10, true),
                                            child: Text(
                                              "일",
                                              style: TextStyle(
                                                  fontSize: daySelectFontSize),
                                            )),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          checkedDayList[6] =
                                          checkedDayList[6] ? false : true;
                                        });
                                      },
                                    ),
                                  ])
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
                                    width: getMobileSizeFromPercent(context, 20, true),
                                    height: 40,
                                    child: Text(
                                      alertState,
                                      style: TextStyle(
                                          fontSize: alertStateFontSize),
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
                                    width: getMobileSizeFromPercent(context, 40, true),
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
                                      style: TextStyle(
                                          fontSize: alertTimeFontSize),
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

                        Container(
                          height: 10,
                        ),

                        // 뒤로가기
                        Container(
                          width: getMobileSizeFromPercent(context, 80, true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // 완료
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius: BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(
                                      getMobileSizeFromPercent(
                                          context, 35, true),
                                      getMobileSizeFromPercent(context, 6, false)),
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                ),
                                child: Text(
                                  "완료",
                                  style: TextStyle(fontSize: btnTitleFontSize),
                                ),
                                onPressed: () async {
                                  if (await editDaily() == 0) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg:
                                        "${titleController.text}을(를) 수정했습니다.");
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                        "수정을 실패했습니다.");
                                  }
                                },
                              ),
                              // 취소
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius: BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(
                                      getMobileSizeFromPercent(
                                          context, 35, true),
                                      getMobileSizeFromPercent(context, 6, false)),
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

  // 요일 체크 상태 리스트
  void updateCheckedDayList(String str) {
    if (str.contains("월")) // 월
      checkedDayList[0] = true;
    else
      checkedDayList[0] = false;
    if (str.contains("화")) // 화
      checkedDayList[1] = true;
    else
      checkedDayList[1] = false;
    if (str.contains("수")) // 수
      checkedDayList[2] = true;
    else
      checkedDayList[2] = false;
    if (str.contains("목")) // 목
      checkedDayList[3] = true;
    else
      checkedDayList[3] = false;
    if (str.contains("금")) // 금
      checkedDayList[4] = true;
    else
      checkedDayList[4] = false;
    if (str.contains("토")) // 토
      checkedDayList[5] = true;
    else
      checkedDayList[5] = false;
    if (str.contains("일")) // 일
      checkedDayList[6] = true;
    else
      checkedDayList[6] = false;
  }

  /// 정보 받아옴
  Future<int> getDailyEdit(int id) async {
    String getDailyURI = hostURI +
        'api/daily/' +
        dayilyId.toString() +
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
        titleController.text = res.data['title'];
        updateCheckedDayList(res.data['alertDates']);
        contentController.text = res.data['content'];
        this.alertTime = res.data['alertTime'];
        this.alertState = res.data['alertStatus'];
      });
      print("====================");
      print("sucess getDailyEdit");
      return 0;
    } catch (e) {
      print("====================");
      print("getDailyEdit Err");
    }
    return -1;
  }

  /// 수정
  Future<int> editDaily() async {
    if (titleController.text == "") {
      return -1;
    }
    // checkedDayStr 갱신
    List dayList = ["월", "화", "수", "목", "금", "토", "일"];
    for (int i = 0; i < dayList.length; i++) {
      if (checkedDayList[i]) {
        checkedDayStr += dayList[i];
      }
    }
    String createDailyURI = hostURI + 'api/daily/' + dayilyId.toString();
    Map body = {
      'title': titleController.text.toString(),
      'content': contentController.text.toString(),
      'alertStatus': alertState,
      'alertTime': alertTime.toString(),
      'alertDates': checkedDayStr.toString(),
    };
    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var response = await dio.put(createDailyURI, data: body);
      print('====================');
      print('sucess editDaily');
      return 0;
    } catch (e) {
      print('====================');
      print('editDailyErr');
      return -1;
    }
  }
}
