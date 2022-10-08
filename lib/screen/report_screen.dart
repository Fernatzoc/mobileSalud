import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Proximamente...',
            style: TextStyle(
                fontFamily: 'NotoSans',
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Image(image: AssetImage('assets/building.png'))
        ],
      ),
    );
  }
}
