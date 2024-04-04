import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                './assets/icon/Community-icon.svg',
                width: 28,
                height: 28,
              ),
              label: '주',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                './assets/icon/cook_icon.svg',
                width: 28,
                height: 28,
              ),
              label: '식',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                './assets/icon/clothes_icon.svg',
                width: 28,
                height: 28,
              ),
              label: '의',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                './assets/icon/mypage_icon.svg',
                width: 28,
                height: 28,
              ),
              label: '내정보',
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
