import 'package:flutter/material.dart';

// 각 페이지들 import
import 'testPage.dart';
import 'Sign_Up.dart';
import 'Real_Main.dart';
import 'Achieved_Goal.dart';
import 'ViewDaily.dart';
import 'CreateDaily.dart';
import 'ViewGoal.dart';
import 'CreateGoal.dart';

void main() {
  runApp(const MyApp());
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
                      context, MaterialPageRoute(builder: (_) => TestPage()));
                },
                child: Text("testPage")),
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

            // View Goal 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewGoal()));
                },
                child: Text("ViewGoal")),

            // Create Goal 페이지
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CreateGoal()));
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
