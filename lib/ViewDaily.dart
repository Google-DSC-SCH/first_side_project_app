import 'package:flutter/material.dart';

class ViewDaily extends StatefulWidget{
  @override
  State<ViewDaily> createState() => _ViewDaily();
}

class _ViewDaily extends State<ViewDaily>{
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      child: ElevatedButton(onPressed: ()=>null, child:Text("안녕하세용"))
    ),
  );
}