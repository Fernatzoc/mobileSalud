import '../global/environment.dart';
import 'download_service.dart';

Future<void> downloadFilePdf() async {
  DownloadService downloadService = MobileDownloadService();
  await downloadService.download(
      url: '${Environment.apiUrl}/download.pdf', mimeType: 'application/pdf');
}

Future<void> downloadFileExcel() async {
  DownloadService downloadService = MobileDownloadService();
  await downloadService.download(
      url: '${Environment.apiUrl}/downloadExcel.xlsx',
      mimeType: 'application/vnd.ms-excel');
}
