import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'Notification_controller.dart';

// 각 페이지들 import
import 'Login.dart';
import 'Sign_Up.dart';
import 'Real_Main.dart';
import 'Achieved_Goal.dart';
import 'ViewDaily.dart';
import 'CreateDaily.dart';
import 'ViewGoal.dart';
import 'CreateGoal.dart';
import 'Create_Diary.dart';
import 'View_Diary.dart';

Future<void> main() async {
  // 초기화 허용
  WidgetsFlutterBinding.ensureInitialized();
  // 파이어베잇스 추가
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'HandTyping',
        primarySwatch: Colors.blue,
      ),
      initialBinding: BindingsBuilder.put(()=>NotificationController(), permanent: true),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 화면 이동 버튼, 새로운 페이지 만들때마다 복사해서 사용
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Login()));
                },
                child: Text("Login")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Sign_Up()));
                },
                child: Text("Sign_Up")),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Real_Main()));
                },
                child: Text("Real_Main")),
            // View Daily 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewDaily()));
                },
                child: Text("ViewDaily")),

            // Create Daily 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateDaily()));
                },
                child: Text("CreateDaily")),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Create_Diary()));
                },
                child: Text("Create_Diary")),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => View_Diary()));
                },
                child: Text("View_Diary")),

            // View Goal 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => ViewGoal()));
                },
                child: Text("ViewGoal")),

            // Create Goal 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CreateGoal()));
                },
                child: Text("CreateGoal")),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => Achieved_Goal()));
                },
                child: Text("Achieved_Goal")),
          ],
        ),
      ),
    );
  }
}
