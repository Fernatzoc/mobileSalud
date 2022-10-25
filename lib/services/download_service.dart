import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class DownloadService {
  Future<void> download({required String url});
}

// class WebDownloadService implements DownloadService {
//   @override
//   Future<void> download({required String url}) async {
//     html.window.open(url, "_blank");
//   }
// }

class MobileDownloadService implements DownloadService {
  // @override
  // Future<void> download({required String url}) async {
  //   bool hasPermission = await _requestWritePermission();
  //   if (!hasPermission) return;

  //   Dio dio = Dio();
  //   var dir = await getApplicationDocumentsDirectory();

  //   // You should put the name you want for the file here.
  //   // Take in account the extension.
  //   String fileName = 'myFile';
  //   await dio.download(url, "${dir.path}/$fileName");
  //   OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
  // }

  // Future<bool> _requestWritePermission() async {
  //   await Permission.storage.request();
  //   return await Permission.storage.request().isGranted;
  // }

  @override
  Future<void> download({required String url}) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) {
      openAppSettings();
    }

    Dio dio = Dio();

    // You should put the name you want for the file here.
    // Take in account the extension.
    final String fileName = Uri.parse(url).path.split("/").last;

    Directory? directory;
    directory = await getTemporaryDirectory();

    // print('Temp cache save path: ${directory.path}/$fileName');

    await dio.download(url, '${directory.path}/$fileName');

    // await dio.download(url, "${dir.path}/$fileName");
    // OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');

    if (Platform.isAndroid) {
      final params =
          SaveFileDialogParams(sourceFilePath: '${directory.path}/$fileName');
      await FlutterFileDialog.saveFile(params: params);

      // final filePath = await FlutterFileDialog.saveFile(params: params);
      // print('Download path: $filePath');
    }
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}
