import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationController extends GetxController {
  // 메시징 서비스 기본 객체 생성
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async{
    super.onInit();
    // TODO: implement onInit
    // 첫 빌드시, 권한 확인하기
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    _onMessage();
  }

  //안드로이드에서 foreground 알림 위한 flutter_local_notification 라이브러리

  // // channel 생성 (우리의 알림을 따로 전달해줄 채널을 직접 만든다)
  // final AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   description: 'This channel is used for important notifications.', // description
  //   importance: Importance.max,
  // );
  //
  // // 2. 그 채널을 우리 메인 채널로 정해줄 플러그인을 만들어준다.
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();

  void _onMessage() async{
    // 1. 위에서 생성한 channel 을 플러그인 통해 메인 채널로 설정한다.
    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);
    //
    // // 2. 플러그인을 초기화하여 추가 설정을 해준다.
    // await flutterLocalNotificationsPlugin.initialize(
    //     const InitializationSettings(
    //         android: AndroidInitializationSettings('@mipmap/ic_launcher'),),
    //     );


    // 1. 콘솔에서 발송하는 메시지를 message 파라미터로 받아온다.
    /// 메시지가 올 때마다 listen 내부 콜백이 실행된다.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // android 일 때만 flutterLocalNotification 을 대신 보여주는 거임. 그래서 아래와 같은 조건문 설정.
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     NotificationDetails(
      //       android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channelDescription: channel.description
      //       ),
      //     ),
      //
      //     // 넘겨줄 데이터가 있으면 아래 코드를 써주면 됨.
      //     // payload: message.data['argument']
      //   );
      // }
    });
  }
}