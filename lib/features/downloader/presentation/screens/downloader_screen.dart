import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DownloaderScreen extends StatelessWidget {
  final String title;
  const DownloaderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: IconButton(
        color: Colors.deepPurpleAccent[400],
        onPressed: () {},
        icon: const Icon(Icons.download),
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 232, 220, 253),
            child: const ListTile(
              title: Text(
                "Title",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text("Progress Bar"),
            ),
          )
        ],
      ),
    );
  }
}
