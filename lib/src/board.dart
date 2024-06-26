import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  final int numCellsX;
  final int numCellsY;

  const Board({required this.numCellsX, required this.numCellsY, super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  late List<List<bool>> _cells;

  @override
  void initState() {
    _initializeCells();
    Timer.periodic(
        const Duration(milliseconds: 100), (_) => _goToNextGeneration());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ..._cells.map((rowOfCells) => Row(
              children: [
                ...rowOfCells.map(
                  (cell) => Container(
                      height: size.height / widget.numCellsY,
                      width: size.width / widget.numCellsX,
                      color: cell ? Colors.black : Colors.white),
                )
              ],
            ))
      ],
    );
  }

  void _initializeCells() {
    _cells = List.generate(
      widget.numCellsY,
      (_) => List.generate(widget.numCellsX, (__) => Random().nextInt(9) == 2),
    );
  }

  void _goToNextGeneration() {
    List<List<bool>> nextGen = List.generate(
        widget.numCellsY,
        (yPos) => List.generate(
            widget.numCellsX, (xPos) => _willBeAliveNextGen(xPos, yPos)));

    setState(() {
      _cells = nextGen;
    });
  }

  bool _willBeAliveNextGen(int xPos, int yPos) {
    final aliveNeighbours = _getAliveNeighboursForCell(xPos, yPos);
    if (_cells[yPos][xPos]) {
      return aliveNeighbours > 1 && aliveNeighbours < 4;
    } else {
      return aliveNeighbours == 3;
    }
  }

  int _getAliveNeighboursForCell(int xPos, int yPos) {
    int aliveNeighbours = 0;

    for (int i = yPos - 1; i <= yPos + 1; i++) {
      for (int j = xPos - 1; j <= xPos + 1; j++) {
        //dont count self
        if (i == yPos && j == xPos) {
          continue;
        } else if (i >= 0 &&
            j >= 0 &&
            i < _cells.length &&
            j < _cells[i].length &&
            _cells[i][j]) {
          aliveNeighbours++;
        }
      }
    }
    return aliveNeighbours;
  }
}
