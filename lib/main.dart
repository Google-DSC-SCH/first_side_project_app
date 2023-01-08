import 'package:first_side_project_app/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// 각 페이지들 import
import 'Login.dart';

/// 플러그인 생성
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'HandTyping',
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  /// 옵저버 추가
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _init();
  }

  /// 옵저버 제거
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  /// 앱 실행될때 뱃지 초기화
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FlutterAppBadger.removeBadge();
    }
  }

  /// 빌드
  @override
  Widget build(BuildContext context) {
    requestPermissions();
    return Login();
  }
}

/// local notification 초기화
Future<void> _init() async {
  await configureLocalTimeZone();
  await initializeNotification();
}

/// 로컬 시간 설정
Future<void> configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}

/// 알림 초기화
Future<void> initializeNotification() async {
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

/// 메시지 등록 취소
Future<void> cancelNotification() async {
  await flutterLocalNotificationsPlugin.cancelAll();
}

/// 권한 요청
Future<void> requestPermissions() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

/// 메시지 등록
Future<void> registerMessage({
  required int notificationId,
  required int year,
  required int month,
  required int day,
  required int hour,
  required int minutes,
  required message,
  required String target
}) async {
  // 시간 초기화
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  // 시간 설정
  tz.TZDateTime scheduledDate = tz.TZDateTime(
    tz.local,
    year,
    month,
    day,
    hour,
    minutes,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId,
    '오늘도 내일도',
    message,
    scheduledDate,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        priority: Priority.high,
        ongoing: true,
        styleInformation: BigTextStyleInformation("알림: " + message),
        // icon: 'noti_icon',
      ),
      iOS: const DarwinNotificationDetails(
        badgeNumber: 1,
      ),
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,

    matchDateTimeComponents: target=="daily"?DateTimeComponents.dayOfWeekAndTime:DateTimeComponents.time,

  );
}
