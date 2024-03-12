import 'package:flutter/material.dart';
import 'package:ollive_front/widgets/global/appbar_widget.dart';
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
  int _selectedIndex = 0;

  final List<Widget> _page = [
    const BoardScreen(),
    const RecipeScreen(),
    const ClothseScreen(),
    const MypageScreen(),
  ];

  final List<String> _title = [
    '게시판',
    '레시피 추천',
    '오늘의 패션',
    '',
  ];

  void _onTapNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppbar(title: _title[_selectedIndex]),
        ),
        bottomNavigationBar: CustomNavigationbar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onTapNavBar,
        ),
        body: _page[_selectedIndex],
      ),
    );
  }
}

class ClothseScreen extends StatelessWidget {
  const ClothseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('옷');
  }
}

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('레시피');
  }
}

class BoardScreen extends StatelessWidget {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('게시판');
  }
}

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('마이페이지');
  }
}
