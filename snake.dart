import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  final int rows;
  final int columns;
  final double cellSize;

  const Snake({
    Key? key,
    required this.rows,
    required this.columns,
    required this.cellSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: rows * columns,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        int row = index ~/ columns;
        int column = index % columns;

        return Container(
          margin: EdgeInsets.all(1),
          color:
              (row + column) % 2 == 0 ? Colors.green[300] : Colors.green[500],
        );
      },
    );
  }
}
