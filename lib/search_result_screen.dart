import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  final int rows;
  final int columns;
  final List<List<String>> grid;

  SearchResultScreen({Key? key, required this.rows, required this.columns, required this.grid}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String searchText = '';

  List<String> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                        search();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter text to search',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      search();
                    });
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.columns,
              ),
              itemCount: widget.rows * widget.columns,
              itemBuilder: (context, index) {
                int row = index ~/ widget.columns;
                int column = index % widget.columns;
                String alphabet = widget.grid[row][column];
                bool isHighlighted = searchResult.contains("$row$column");
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: isHighlighted ? Colors.yellow : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text(alphabet),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void search() {
    setState(() {
      searchResult.clear();
      for (int i = 0; i < widget.rows; i++) {
        for (int j = 0; j < widget.columns; j++) {
          if (widget.grid[i][j] == searchText) {
            searchResult.add("$i$j");
          }
        }
      }
    });
  }
}
