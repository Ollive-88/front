import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:ollive_front/screens/board/board_search_screen.dart';
import 'package:ollive_front/screens/board/board_write_screen.dart';
import 'package:ollive_front/screens/home_screen.dart';
import 'package:ollive_front/screens/splash_screen.dart';
import 'package:ollive_front/screens/user/authentication/login_screen.dart';
import 'package:ollive_front/screens/user/authentication/signin_screen.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

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
    // GetX 상태관리 전역 선언
    Get.put(StatusController());
    // 라우터 관리
    return GetMaterialApp(
      initialRoute: '/',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/board/search': (context) => const BoardSearchScreen(),
        '/board/write': (context) => BoardWriteScreen(),
        '/login': (context) => const LoginScreen(),
        '/signin': (context) => const SigninScreen(),
      },
      // 한글 사용 설정
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale(
          'ko',
        ),
        Locale(
          'en',
        ),
      ],
      // 폰트 전역 설정
      theme: ThemeData(
        fontFamily: 'NanumSquare',
      ),
      home: const SplashScreen(),
    );
  }
}
