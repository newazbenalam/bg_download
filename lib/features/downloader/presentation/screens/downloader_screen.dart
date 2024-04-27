import 'package:bg_download/features/downloader/presentation/provider/downloader_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        onPressed: () {
          context.read<DownloaderProvider>().downloadFile();
        },
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.download),
        ),
      ),
      body: Column(
        children: [
          context.watch<DownloaderProvider>().progress == 0
              ? const Center(
                  child: Text("Click download button to start."),
                )
              : Container(
                  color: const Color.fromARGB(255, 232, 220, 253),
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Demo Download",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${context.watch<DownloaderProvider>().progress.roundToDouble()}%",
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    subtitle: LinearProgressIndicator(
                      value: context.watch<DownloaderProvider>().progress / 100,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
