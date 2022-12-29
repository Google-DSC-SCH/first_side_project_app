import 'package:flutter/material.dart';
import 'BaseFile.dart';

class EditGoal extends StatefulWidget {
  @override
  State<EditGoal> createState() => _EditGoal();
}

class _EditGoal extends State<EditGoal> {
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
  }

  @override
  Widget build(BuildContext context) =>
      Container(
        // 상태바 높이만큼 띄우기
        margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .padding
            .top),
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
                      MediaQuery
                          .of(context)
                          .padding
                          .top * 2,
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
                                    child: Text(
                                        this.duoDay.substring(0, 4) +
                                            "-" +
                                            this.duoDay.substring(4, 6) +
                                            "-" +
                                            this.duoDay.substring(6, 8),
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ),
                                onTap: () {
                                  // 목표 기간 변경
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime(int.parse(duoDay.substring(0,4),), int.parse(duoDay.substring(4,6),),int.parse(duoDay.substring(6,8),)),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2300))
                                      .then((value) {
                                    setState(() {
                                      duoDay =
                                          value!.year.toString() +
                                              (value!.month < 10 ? "0" +
                                                  value.month.toString() : value
                                                  .month.toString()) +
                                              (value!.day < 10 ? "0" + value!.day.toString() : value!.day.toString());
                                      print(duoDay);
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
                                      style: TextStyle(fontSize: 20),
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
}
