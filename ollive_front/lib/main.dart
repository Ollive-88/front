import 'package:flutter/material.dart';
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

  final List<Widget> _page = [];

  void _onTapNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NanumSquare'),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        bottomNavigationBar: CustomNavigationbar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onTapNavBar,
        ),
        body: _page[_selectedIndex],
      ),
    );
  }
}
