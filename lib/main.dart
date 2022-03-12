import 'package:flutter/material.dart';
import 'TakeData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Two Image Merging',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: const Color(0xFFF8F8F8),
          primaryColor: ConstVar.primaryColour,
          appBarTheme: const AppBarTheme(
            backgroundColor: ConstVar.primaryColour,
            elevation: 0,
            iconTheme: IconThemeData(
              color: ConstVar.bgCode,
              size: 25,
            ),
            titleTextStyle: TextStyle(
                fontSize: 17,
                fontFamily: ConstVar.fontFamily,
                fontWeight: FontWeight.normal,
                color: ConstVar.bgCode),
          )),
      home: const TakeData(),
    );
  }
}

class ConstVar{
  static const String fontFamily = 'WorkSans';
  static const Color fontColour = Color(0xFF021F3F);
  static const Color primaryColour = Color(0xFFDE561C);
  static const Color bgCode = Color(0xFFFFFFFF);
}
