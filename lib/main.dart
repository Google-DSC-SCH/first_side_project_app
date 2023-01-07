import 'package:first_side_project_app/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 각 페이지들 import
import 'Login.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> main() async {

  runApp(const MyApp());
  await initNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'HandTyping',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Login();
    // return ViewGoal(11);
  }
}

Future<void> initNotification() async {
  // 알림 플러그인 생성
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
// 안드로이드 초기화
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
// 안드로이드 초기화 등록
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,);
  // 초기화 최종 설정
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (details) => print("알림"),);
}