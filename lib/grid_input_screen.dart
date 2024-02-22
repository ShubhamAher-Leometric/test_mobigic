import 'package:flutter/material.dart';
import 'package:test_mobigic/search_result_screen.dart';

class GridInputScreen extends StatefulWidget {
  final int rows;
  final int columns;

  const GridInputScreen({Key? key, required this.rows, required this.columns}) : super(key: key);

  @override
  State<GridInputScreen> createState() => _GridInputScreenState();
}

class _GridInputScreenState extends State<GridInputScreen> {
  List<List<String>> grid = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.rows; i++) {
      grid.add(List<String>.filled(widget.columns, ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Alphabets'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.columns,
                ),
                itemCount: widget.rows * widget.columns,
                itemBuilder: (context, index) {
                  int row = index ~/ widget.columns;
                  int column = index % widget.columns;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0, // Adjust vertical padding
                      horizontal: 2.0, // Adjust horizontal padding
                    ),
                    child: TextField(
                      onChanged: (value) {
                        grid[row][column] = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Create Grid Button
          ElevatedButton(
            onPressed: () {
              bool allFilled = true;
              for (var row in grid) {
                if (row.contains('')) {
                  allFilled = false;
                  break;
                }
              }
              if (allFilled) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultScreen(
                      rows: widget.rows,
                      columns: widget.columns,
                      grid: grid,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Please fill all Grids with alphabets.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text('Create Grid'),
          ),
        ],
      ),
    );
  }
}
