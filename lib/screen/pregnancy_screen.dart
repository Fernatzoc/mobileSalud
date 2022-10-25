import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';
import '../providers/index.dart';
import '../services/download_service.dart';

class PregnacyScreen extends StatelessWidget {
  const PregnacyScreen({super.key});

  Future<void> _downloadFilePdf() async {
    DownloadService downloadService = MobileDownloadService();
    await downloadService.download(
        url: 'http://10.0.2.2:8000/api/download.pdf');
  }

  Future<void> _downloadFileExcel() async {
    DownloadService downloadService = MobileDownloadService();
    await downloadService.download(
        url: 'http://10.0.2.2:8000/api/downloadExcel.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    final pregnants = Provider.of<PregnancyService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => {},
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                onTap: _downloadFilePdf,
                child: const Text("Exportar a PDF"),
              ),
              PopupMenuItem<int>(
                value: 1,
                onTap: _downloadFileExcel,
                child: const Text("Exportar a Excel"),
              ),
            ];
          }),
        ],
      ),
      body: pregnants.pregnantsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => pregnants.getPregnants(1),
              child: ListView.builder(
                itemCount: pregnants.pregnantsList.length,
                itemBuilder: (context, index) {
                  return _CardPregnant(
                      pregnant: pregnants.pregnantsList[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff6A7AFA),
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'createRegister'),
      ),
    );
  }
}

class _CardPregnant extends StatelessWidget {
  final Pregnant pregnant;

  const _CardPregnant({
    Key? key,
    required this.pregnant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'singlePregnant', arguments: pregnant),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xff6A7AFA),
            child: Text(pregnant.nombres[0],
                style: const TextStyle(color: Colors.white)),
          ),
          title: Text('${pregnant.nombres} ${pregnant.apellidos}'),
          subtitle: Text('Cui: ${pregnant.cui}'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
