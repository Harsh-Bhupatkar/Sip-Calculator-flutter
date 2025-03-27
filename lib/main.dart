import 'package:flutter/material.dart';
import 'package:sip_calculator/sip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(232, 181, 51, 1),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25)
        ),
        useMaterial3: true,
      ),
      home: SipScreen(),
    );
  }
}

