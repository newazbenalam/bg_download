import 'package:bg_download/core/notification_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloaderProvider extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  double _progress = 0;

  double get progress => _progress;

  void showNotification(int progress, String subTitle) {
    _notificationService.createNotification(
      100,
      progress,
      2, // notification ID, implemet if multiple file downloading in parallel
      "Now Downloading",
      subTitle,
    );
  }

  Future<void> downloadFile() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    debugPrint(statuses[Permission.storage].toString());

    showNotification(0, 'Starting!');
    final dio = Dio();
    const savePath = '/sdcard/Download/';
    const url =
        "https://file-examples.com/storage/feeb836c2d66294eb99ac59/2017/04/file_example_MP4_1920_18MG.mp4";

    try {
      await dio.download(
        url,
        savePath + url.split('/').last,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (totalBytes != -1) {
            _progress = (receivedBytes / totalBytes) * 100;
            // saving msg overflowing
            if (_progress.round() % 2 == 0) {
              showNotification(
                _progress.toInt(),
                '${_progress.roundToDouble()} %',
              );
            }
            notifyListeners();
          }
        },
      );
      // most off the devices doesn't get along with changing same notification channel id so hence 1s delay
      Future.delayed(const Duration(seconds: 1), () {
        _notificationService.showNotification(
          id: 2,
          title: "Download Complete",
          body: savePath + url.split('/').last,
        );
      });
    } catch (e) {
      // Handle error
      debugPrint(e.toString());
      _notificationService.showNotification(
        id: 2,
        title: "Download Failed!",
        body: "",
      );
    }
  }
}
