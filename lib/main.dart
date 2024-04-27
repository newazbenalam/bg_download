import 'package:bg_download/core/notification_services.dart';
import 'package:bg_download/features/downloader/presentation/provider/downloader_provider.dart';
import 'package:bg_download/features/downloader/presentation/screens/downloader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService notificationServices = NotificationService();
  notificationServices.initializeNotifications();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => DownloaderProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Downloader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const DownloaderScreen(title: 'Downloader'),
      initialRoute: '/', // for handling notificaiton payload
      routes: {
        '/': (context) => const DownloaderScreen(
              title: 'Downloader',
            ),
      },
    );
  }
}
