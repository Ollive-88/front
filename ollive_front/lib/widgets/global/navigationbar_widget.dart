import 'package:flutter/material.dart';
import 'package:ollive_front/util/icons/ollive_icons.dart';

class CustomNavigationbar extends StatelessWidget {
  const CustomNavigationbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final int selectedIndex;
  // ignore: prefer_typing_uninitialized_variables
  final onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 10,
        )
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF6F6F4),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                OlliveIcons.boardicon,
                color: Colors.black,
              ),
              label: 'Board',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                OlliveIcons.recipeicon,
                color: Colors.black,
              ),
              label: 'Recipe',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                OlliveIcons.clothseicon,
                color: Colors.black,
              ),
              label: 'Clothse',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                OlliveIcons.profileicon,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
