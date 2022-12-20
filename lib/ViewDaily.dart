import 'package:flutter/material.dart';
import 'getMediaQuery.dart';

class ViewDaily extends StatefulWidget {
  @override
  State<ViewDaily> createState() => _ViewDaily();
}

class _ViewDaily extends State<ViewDaily> {
  String title = "";
  String content = "";
  String repeatDay = "";
  String alarmOnOff = "";
  String alarmTime = "";
  int selectedState = 0;
  int stateComColor = 0;
  int stateUncomColor = 0;

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

    this.title = "제목입니다.";
    this.content =

        "대충 설명을 하자면 이런 느낌.\n뭔지 알지? 몰라도 알아야돼. 라때는 말이야 이러쿵저러쿵 꼰대 마인드 ON\n 집가고싶다..";
        "대충 설명을 하자면 이런 느낌.\n뭔지 알지? 몰라도 \n\n\n\n\n\n\n\n\n\n\n알아야돼. 라때는 말이야 이러쿵저러쿵 꼰대 마인드 ON\n 집가고싶다..";
    this.repeatDay = "월, 수, 금";
    this.alarmOnOff = "ON";
    this.alarmTime = "오후 7:30";
    this.selectedState = 0;
    this.stateComColor = color_whiteYellow;
    this.stateUncomColor = color_realYellow;
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
                          Text("제목",
                              style: TextStyle(fontSize: titleFontSize)),
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
                                width: getMobileSizeFromPercent(
                                    context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 6, false),
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
                          Text("설명",
                              style: TextStyle(fontSize: titleFontSize)),
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
                                width: getMobileSizeFromPercent(
                                    context, 80, true),
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
                                    style:
                                        TextStyle(fontSize: titleFontSize)),
                                Text(this.alarmOnOff,
                                    style: TextStyle(fontSize: 25)),
                              ],
                            ),
                            Text(
                              this.alarmTime,
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      // 상태
                      Container(
                        width: getMobileSizeFromPercent(context, 65, true),
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
                                    color: Color(stateComColor),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 80,
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
                                      stateComColor = color_realYellow;
                                      stateUncomColor = color_whiteYellow;
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
                                    color: Color(stateUncomColor),
                                    elevation: 0, // 그림자 깊이
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 80,
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
                                      stateComColor = color_whiteYellow;
                                      stateUncomColor = color_realYellow;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius:
                                          BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(80, 40),
                                  //width, height
                                  shadowColor: Colors.transparent),
                              child: Text(
                                "수정",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () => null,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius:
                                          BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(80, 40),
                                  shadowColor: Colors.transparent),
                              child: Text(
                                "삭제",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      //모서리를 둥글게
                                      borderRadius:
                                          BorderRadius.circular(16)),
                                  primary: Color(color_mint),
                                  onPrimary: Colors.black,
                                  minimumSize: Size(80, 40),
                                  shadowColor: Colors.transparent),
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
}
