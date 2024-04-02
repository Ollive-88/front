import 'package:flutter/material.dart';

class MyArticleScreen extends StatefulWidget {
  const MyArticleScreen({super.key});

  @override
  State<MyArticleScreen> createState() => _MyArticleScreenState();
}

class _MyArticleScreenState extends State<MyArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 게시글'),
        centerTitle: true,
      ),
      // 이거 Future Builder로 만들어야함!
      body: const SafeArea(
        child: Column(
          children: [Text('내 게시글')],
        ),
      ),
    );
  }
}
