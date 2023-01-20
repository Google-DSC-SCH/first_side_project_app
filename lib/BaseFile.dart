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
double logoDateFontSize = 23;
// 타이틀 폰트 사이즈
double titleFontSize = 19;
// 버튼 텍스트 크기
double btnTitleFontSize = 18;
// 알림 상태
double alertStateFontSize = 20;
// 알림 시간
double alertTimeFontSize = 20;
// View title 폰트
double viewTitleFontSize = 20;
// view content 폰트
double viewContentFontSize = 17;

// ==== 메인 ====
// 리스트 항목 타이틀 폰트 사이즈
double listTitleFontSize = 18;
// 리스트 항목 서브 타이틀 폰트 사이즈
double listTitleSubFontSize = 14;
// 추가 버튼 사이즈
double addBtnIconSize = 30;
// 토글 사이즈
double togleSize = 30;

// ==== 달성률 페이지 ====
// 요일 폰트 사이즈
double achievementDayFontSize = 22;
// 퍼센트 설명 폰트 사이즈
double achievementPercentFontSize = 16;

// ==== daily ====
// 요일 폰트 사이즈(알림 날짜 선택)
double daySelectFontSize = 17;
// view 반복 요일 폰트 사이즈
double viewDailyDateFontSize = 20;

// ==== goal ====
// 목표 기간 폰트 사이즈
double duoDayFontSize = 20;
// 달성 여부 상태 폰트 사이즈
double goalStateFontSize = 20;

// ==== diary ====
// 일기 내용 폰트 크기
double diaryContentFontSize = 25;

/// 모바일 화면 구하는 함수(context, 변환하고자 하는 퍼센테이지, 가로,세로 여부/가로 true, 세로: false)
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

