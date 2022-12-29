import 'package:flutter/material.dart';
import 'BaseFile.dart';

class CreateDaily extends StatefulWidget {
  @override
  State<CreateDaily> createState() => _CreateDaily();
}

class _CreateDaily extends State<CreateDaily> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // 완료: 0, 미완료: 1
  int selectedState = 0;

  // 요일 상테 텍스트
  String checkedDayStr = "월수일";

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
  String? selectedTime;

  // 위젯간 간격(세로)
  double titleFontSize = 17;

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

    this.selectedState = 0;

    updateCheckedDayList(this.checkedDayStr);
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
                              Text("반복요일",
                                  style: TextStyle(fontSize: titleFontSize)),
                              Row(children: [
                                // 월
                                GestureDetector(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[0]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "월",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[1]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "화",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[2]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "수",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[3]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "목",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[4]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "금",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[5]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "토",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    shape: RoundedRectangleBorder(
                                      //모서리를 둥글게 하기 위해 사용
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    color: Color(checkedDayList[6]
                                        ? color_realYellow
                                        : color_whiteYellow),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: getMobileSizeFromPercent(
                                            context, 9, true),
                                        height: getMobileSizeFromPercent(
                                            context, 10, true),
                                        child: Text(
                                          "일",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
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
                                    width: 60,
                                    height: 40,
                                    child: Text(
                                      alertState,
                                      style: TextStyle(
                                          fontSize: 20,
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
                                      style: TextStyle(
                                          fontSize: 20),
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
                                            fontSize: 20,
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
                                            fontSize: 20,
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
                              ElevatedButton(
                                // 완료
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        //모서리를 둥글게
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    primary: Color(color_mint),
                                    onPrimary: Colors.black,
                                    minimumSize: Size(
                                        getMobileSizeFromPercent(
                                            context, 30, true),
                                        40),
                                    shadowColor: Colors.transparent,
                                  elevation: 0,),
                                child: Text(
                                  "완료",
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              // 취소
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        //모서리를 둥글게
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    primary: Color(color_mint),
                                    onPrimary: Colors.black,
                                    minimumSize: Size(
                                        getMobileSizeFromPercent(
                                            context, 30, true),
                                        40),
                                    shadowColor: Colors.transparent,
                                  elevation: 0,),
                                child: Text(
                                  "취소",
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
}
