import 'package:flutter/material.dart';
import 'package:ollive_front/screens/board/board_screen.dart';
import 'package:ollive_front/screens/cloth/cloth_screen.dart';
import 'package:ollive_front/screens/user/mypage_screen.dart';
import 'package:ollive_front/screens/recipe/recipe_screen.dart';
import 'package:ollive_front/widgets/global/navigationbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  ScrollController boardScrollController = ScrollController();

  void _onTapNavBar(int index) {
    if (index == _selectedIndex && index == 0) {
      boardScrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      bottomNavigationBar: CustomNavigationbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onTapNavBar,
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: BoardScreen(
              boardScrollController: boardScrollController,
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const RecipeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const ClothScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: MyPageScreen(),
          ),
        ],
      ),
    );
  }
}
