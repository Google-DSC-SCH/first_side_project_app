import 'package:flutter/cupertino.dart';

/// 컬러
// 연노랑
int color_whiteYellow = 0xFFFAF4B7;
// 찐노랑
int color_realYellow = 0xFFFFD966;
// 민트
int color_mint = 0xFFCDF0EA;

/// 사이즈
// 타이틀 폰트 사이즈
double titleFontSize = 20;
// 서브 타이틀 폰트 사이즈
double subTitleFontSize = 14;
// 리스트 항목 타이틀 폰트 사이즈
double listTitleFontSize = 25;
// 버튼 텍스트 크기
double btnTitleFontSize = 20;

// 모바일 화면 구하는 함수(context, 변환하고자 하는 퍼센테이지, 가로,세로 여부/가로 true, 세로: false)
double getMobileSizeFromPercent(BuildContext context, int percent, bool isWidth){
  if(isWidth){
    return MediaQuery.of(context).size.width * percent / 100;
  }
  else{
    return MediaQuery.of(context).size.height * percent / 100;
  }
}

String getToday(){
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  return year.toString() +
      (month < 10 ? "0" + month.toString() : month.toString()) +
      (day < 10 ? "0" + day.toString() : day.toString());
}

