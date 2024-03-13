import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/api/api_service.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  // final Future<List<dynamic>> instance = ApiService.get("path");

  final List<Board> boards = [];

  void instanceToBoard() {}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
