import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ollive_front/screens/home_screen.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';
import 'package:ollive_front/widgets/global/navigationbar_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    Get.put(StatusController());
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomScreen(),
        '/1': (context) => const Test1(),
        '/2': (context) => const Test2(),
      },
      theme: ThemeData(fontFamily: 'NanumSquare'),
      home: Text("로그인 들어올 자리"),
    );
  }
}
