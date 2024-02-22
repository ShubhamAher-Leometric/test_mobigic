import 'package:flutter/material.dart';
import 'package:test_mobigic/grid_input_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController mController = TextEditingController();
  TextEditingController nController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: mController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of rows (m)',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter number of columns (n)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int m = int.tryParse(mController.text) ?? 0;
                int n = int.tryParse(nController.text) ?? 0;
                if (m > 0 && n > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GridInputScreen(rows: m, columns: n),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Please enter valid values for m and n.'),
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
      ),
    );
  }
}
