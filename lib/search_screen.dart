import 'package:flutter/material.dart';
import 'package:test_mobigic/resultscreen.dart';

class SerachScreen extends StatefulWidget {
  final int rows;
  final int columns;

  // SerachScreen({required this.rows, required this.columns});
  const SerachScreen({super.key, required this.rows, required this.columns});

  @override
  State<SerachScreen> createState() => _SerachScreenState();
}

class _SerachScreenState extends State<SerachScreen> {
  List<List<String>> grid = [];

  @override
  void initState() {
    super.initState();
    // Initialize the grid with empty strings
    for (int i = 0; i < widget.rows; i++) {
      grid.add(List<String>.filled(widget.columns, ''));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Search'),
      ),
      body: Column(
        children: [
          // Grid Input
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
                  return TextField(
                    onChanged: (value) {
                      grid[row][column] = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
            ),
          ),
          // Create Grid Button
          ElevatedButton(
            onPressed: () {
              // Check if all positions are filled
              bool allFilled = true;
              for (var row in grid) {
                if (row.contains('')) {
                  allFilled = false;
                  break;
                }
              }
              if (allFilled) {
                // Navigate to the search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      rows: widget.rows,
                      columns: widget.columns,
                      grid: grid,
                    ),
                  ),
                );
              } else {
                // Show error message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Please fill all positions with alphabets.'),
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

