import 'package:flutter/cupertino.dart';

/// API
String hostURI = 'http://ec2-3-39-219-81.ap-northeast-2.compute.amazonaws.com:9999/';
String token = '';
String refreshToken = '';

/// 컬러
// 연노랑
int color_whiteYellow = 0xFFFAF4B7;
// 찐노랑
int color_realYellow = 0xFFFFD966;
// 민트
int color_mint = 0xFFCDF0EA;
// 하늘
int color_skyBlue = 0xFFB8E8FC;
// 분홍
int color_pink = 0xFFECC5FB;
// 보라
int color_purple = 0xFFB1AFFF;

/// 사이즈

// ==== 공통 ====
// 로고 날짜 사이즈
double logoDateFontSize = 25;
// 타이틀 폰트 사이즈
double titleFontSize = 20;
// 서브 타이틀 폰트 사이즈
double subTitleFontSize = 14;
// 버튼 텍스트 크기
double btnTitleFontSize = 20;
// 설명
double viewContentFontSize = 15;

// ==== 메인 ====
// 리스트 항목 타이틀 폰트 사이즈
double listTitleFontSize = 23;
// 리스트 항목 서브 타이틀 폰트 사이즈
double listTitleSubFontSize = 15;
// 추가 버튼 사이즈
double addBtnIconSize = 30;

// ==== 달성률 페이지 ====
// 요일 폰트 사이즈(달성률 페이지)
double dayFontSize = 25;

// ==== daily ====
// 요일 폰트 사이즈(알림 날짜 선택)
double daySelectFontSize = 15;

// ==== diary ====
// 일기 내용 폰트 크기
double diaryContentFontSize = 30;

// 모바일 화면 구하는 함수(context, 변환하고자 하는 퍼센테이지, 가로,세로 여부/가로 true, 세로: false)
double getMobileSizeFromPercent(BuildContext context, int percent, bool isWidth){
  if(isWidth){
    return MediaQuery.of(context).size.width * percent / 100;
  }
  else{
    return MediaQuery.of(context).size.height * percent / 100;
  }
}

/// 오늘 날짜 반환
String getToday(){
  int year = DateTime.now().year;
  int month = DateTime.now().month;
  int day = DateTime.now().day;
  return year.toString() +
      (month < 10 ? "0" + month.toString() : month.toString()) +
      (day < 10 ? "0" + day.toString() : day.toString());
}

