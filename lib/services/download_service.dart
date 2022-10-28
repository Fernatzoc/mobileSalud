import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class DownloadService {
  Future<void> download({required String url, required String mimeType});
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url, required String mimeType}) async {
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) {
      openAppSettings();
    }

    Dio dio = Dio();

    final String fileName = Uri.parse(url).path.split("/").last;

    Directory? directory;
    directory = await getTemporaryDirectory();

    await dio.download(url, '${directory.path}/$fileName');

    if (Platform.isAndroid) {
      final params = SaveFileDialogParams(
          sourceFilePath: '${directory.path}/$fileName',
          fileName: 'Reporte',
          mimeTypesFilter: [mimeType]);
      await FlutterFileDialog.saveFile(params: params);
    }
  }

  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }
}
