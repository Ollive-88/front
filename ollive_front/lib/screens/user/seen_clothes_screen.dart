import 'package:flutter/material.dart';

class SeenClothesScreen extends StatefulWidget {
  const SeenClothesScreen({super.key});

  @override
  State<SeenClothesScreen> createState() => _SeenClothesScreenState();
}

class _SeenClothesScreenState extends State<SeenClothesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근 본 의류'),
        centerTitle: true,
      ),
      // 이거 Future Builder로 만들어야함!
      body: const SafeArea(
        child: Column(
          children: [Text('최근 본 의류')],
        ),
      ),
    );
  }
}
