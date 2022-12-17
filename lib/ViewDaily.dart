import 'package:flutter/material.dart';
import 'getMediaQuery.dart';

class ViewDaily extends StatefulWidget {
  @override
  State<ViewDaily> createState() => _ViewDaily();
}

class _ViewDaily extends State<ViewDaily> {
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
            body: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 앱 상단 로고
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        22 /
                        100,
                    width: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        10 /
                        100,
                    padding: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            5 /
                            100),
                    child: Image.asset(
                      'assets/img/icon.png',
                    )),

                // Body
                // 세로 화면의 22% 비율부터 시작
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        78 /
                        100,
                    width: MediaQuery.of(context).size.width,
                    // 여기서부터 찐 개발 시작
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 제목
                          Column(
                            children: [
                              Text("제목", style: TextStyle(fontSize: 30)),
                              Card(
                                shape: RoundedRectangleBorder(
                                  //모서리를 둥글게 하기 위해 사용
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                color: Color(0xFFFAF4B7),
                                elevation: 0, // 그림자 깊이
                                child: Container(
                                    width: getMobileSizeFromPercent(
                                        context, 80, true),
                                    child: Text("aa")),
                              ),
                            ],
                          ),

                          // 설명
                          Column(
                            children: [
                              Text("설명"),
                              Card(
                                shape: RoundedRectangleBorder(
                                  //모서리를 둥글게 하기 위해 사용
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                color: Color(0xFFFAF4B7),
                                elevation: 0, // 그림자 깊이
                                child: Container(
                                    width: getMobileSizeFromPercent(
                                        context, 80, true),
                                    child: Text("aa")),
                              ),
                            ],
                          ),

                          // 반복 요일
                          Container(
                            width: getMobileSizeFromPercent(context, 80, true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("반복요일"), Text("월수금")],
                            ),
                          ),

                          // 알림
                          Container(
                            width: getMobileSizeFromPercent(context, 80, true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("알림", style: TextStyle(fontFamily: "HandTyping")), Text("ON"), Text("오후 7:30")],
                            ),
                          ),

                          // 상태
                          Container(
                            width: getMobileSizeFromPercent(context, 80, true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("상태"),
                                ElevatedButton(
                                  onPressed: () => null,
                                  child: Text("완료"),
                                ),
                                ElevatedButton(
                                  onPressed: () => null,
                                  child: Text("미완료"),
                                ),
                              ],
                            ),
                          ),

                          // 뒤로가기
                          Container(
                            width: getMobileSizeFromPercent(context, 80, true),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => null,
                                  child: Text("수정"),
                                ),
                                ElevatedButton(
                                  onPressed: () => null,
                                  child: Text("삭제"),
                                ),
                                ElevatedButton(
                                  onPressed: () => null,
                                  child: Text("뒤로"),
                                ),
                              ],
                            ),
                          ),
                        ]))
              ],
            )),
      );
}
