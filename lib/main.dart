import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran/base/routing.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: PageTo.main,
      getPages: BaseRoute.pages(),
      theme: ThemeData(
        canvasColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black87,
          ),
          centerTitle: true,
          elevation: 0,
        ),
      ),
    );
  }
}
