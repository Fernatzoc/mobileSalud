import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/index.dart';
import '../search/search_delegate.dart';
import '../services/reports_service.dart';
import '../widgets/index.dart';

class PregnacyScreen extends StatelessWidget {
  const PregnacyScreen({super.key});

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
                onTap: () => showSearch(
                    context: context, delegate: PregnantSearchDelegate()),
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                  color: Colors.white,
                ),
              )),
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                onTap: downloadFilePdf,
                child: Text("Exportar a PDF"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                onTap: downloadFileExcel,
                child: Text("Exportar a Excel"),
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
                  return CardPregnant(pregnant: pregnants.pregnantsList[index]);
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
