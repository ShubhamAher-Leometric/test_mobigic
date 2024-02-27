import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchResultScreen extends StatefulWidget {
  final int rows;
  final int columns;
  final List<List<String>> grid;

  SearchResultScreen({
    Key? key,
    required this.rows,
    required this.columns,
    required this.grid,
  }) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String searchText = '';

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
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow only alphabets
                    ],
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter text to search',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
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
                List<bool> highlights = _getLetterHighlights(alphabet);
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: _shouldHighlight(highlights) ? Colors.yellow : Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: _buildHighlightedText(alphabet, highlights),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<bool> _getLetterHighlights(String alphabet) {
    List<bool> highlights = List.filled(alphabet.length, false);
    for (int i = 0; i <= alphabet.length - searchText.length; i++) {
      if (alphabet.substring(i, i + searchText.length).toLowerCase() == searchText.toLowerCase()) {
        for (int j = i; j < i + searchText.length; j++) {
          highlights[j] = true;
        }
      }
    }
    return highlights;
  }

  bool _shouldHighlight(List<bool> highlights) {
    for (bool highlight in highlights) {
      if (highlight) {
        return true;
      }
    }
    return false;
  }

  Widget _buildHighlightedText(String alphabet, List<bool> highlights) {
    List<Widget> letters = [];
    for (int i = 0; i < alphabet.length; i++) {
      letters.add(
        Text(
          alphabet[i],
          style: TextStyle(
            color: highlights[i] ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters,
    );
  }
}
