import 'package:flutter/material.dart';

class FavoriteRecipeScreen extends StatefulWidget {
  const FavoriteRecipeScreen({super.key});

  @override
  State<FavoriteRecipeScreen> createState() => _FavoriteRecipeScreenState();
}

class _FavoriteRecipeScreenState extends State<FavoriteRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾는 레시피'),
        centerTitle: true,
      ),
      // 이거 Future Builder로 만들어야함!
      body: const SafeArea(
        child: Column(
          children: [Text('즐겨찾는 레시피')],
        ),
      ),
    );
  }
}
