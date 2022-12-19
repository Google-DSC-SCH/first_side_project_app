import 'package:flutter/cupertino.dart';

// 모바일 화면 구하는 함수(context, 변환하고자 하는 퍼센테이지, 가로,세로 여부/가로 true, 세로: false)
double getMobileSizeFromPercent(BuildContext context, int percent, bool isWidth){
  if(isWidth){
    return MediaQuery.of(context).size.width * percent / 100;
  }
  else{
    return MediaQuery.of(context).size.height * percent / 100;
  }
}