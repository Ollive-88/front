import 'package:flutter/material.dart';
import 'package:ollive_front/screens/board/board_screen.dart';
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
    if (index == _selectedIndex) {
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
            child: const Test(),
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

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                "data1",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data2",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data3",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data4",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data5",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data6",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data7",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data8",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data9",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data10",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data11",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data12",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data13",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data14",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data15",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data16",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data17",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data18",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data19",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "data20",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: IconButton(
              icon: const Icon(
                Icons.abc,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/1');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: IconButton(
              icon: const Icon(
                Icons.abc,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/2');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Test1 extends StatelessWidget {
  const Test1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: Text("야호"),
          ),
        ],
      ),
    );
  }
}

class Test2 extends StatelessWidget {
  const Test2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: Text("된다"),
          ),
        ],
      ),
    );
  }
}
