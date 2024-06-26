import 'package:flutter/material.dart';
import 'package:game_of_life/src/board.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Board(
        numCellsX: 100,
        numCellsY: 100,
      ),
    );
  }
}
