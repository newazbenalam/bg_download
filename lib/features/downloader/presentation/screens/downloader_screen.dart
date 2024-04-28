import 'package:bg_download/features/downloader/presentation/provider/downloader_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloaderScreen extends StatefulWidget {
  final String title;
  const DownloaderScreen({super.key, required this.title});

  @override
  State<DownloaderScreen> createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<DownloaderProvider>().setDismiss(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<DownloaderProvider>().setDismiss(false);
    } else {
      context.read<DownloaderProvider>().setDismiss(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (context.read<DownloaderProvider>().isDownloading) {
            context
                .read<DownloaderProvider>()
                .showSnackBar(context, "Already in progress!");
            return;
          }
          context.read<DownloaderProvider>().downloadFile();
        },
        child: const Icon(Icons.download),
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
