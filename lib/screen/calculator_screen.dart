import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/operations.dart';
import '../providers/index.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora De Embarazo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [_Calculator()],
          ),
        ),
      ),
    );
  }
}

class _Calculator extends StatelessWidget {
  const _Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calc = Provider.of<Calculator>(context);

    return Form(
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 5),
                      blurRadius: 5)
                ]),
            child: DateTimePicker(
              initialValue: '',
              dateMask: 'd-MM-yyyy',
              firstDate: DateTime(DateTime.now().year, DateTime.now().month - 9,
                  DateTime.now().day),
              lastDate: DateTime.now(),
              dateLabelText: 'Ultima regla o por USG',
              confirmText: 'Aceptar',
              cancelText: 'Cancelar',
              calendarTitle: 'Seleccione Fecha',
              decoration: const InputDecoration(
                hintText: 'Ultima regla o por USG',
                focusedBorder: InputBorder.none,
                label: Text('Ultima regla o por USG'),
                prefixIcon: Icon(Icons.calendar_month_outlined),
                border: InputBorder.none,
              ),
              onChanged: (value) => calc.dateSelected = value,
            ),
          ),
          _InfoState(value: calc.dateSelected)
        ],
      ),
    );
  }
}

class _InfoState extends StatelessWidget {
  final String value;

  const _InfoState({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xff97a2fc),
          ),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: const Text(
            'Edad Gestacional',
            style: TextStyle(
                color: Colors.white, fontFamily: 'NotoSans', fontSize: 15),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(2.0)),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (value != '')
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TitleAndInfo(
                            title: 'Ultima regla', value: formaterDate(value)),
                        const SizedBox(height: 18),
                        _TitleAndInfo(
                            title: 'Trimestre:',
                            value: getQuarterly(formaterDate(value))),
                        const SizedBox(height: 18),
                        _TitleAndInfo(
                            title: 'Semanas',
                            value: getWeeks(formaterDate(value))
                                .toStringAsFixed(2)),
                        const SizedBox(height: 18),
                        _TitleAndInfo(
                          title: 'Fecha prevista de parto',
                          value: getDateOfBirth(formaterDate(value)),
                        ),
                      ],
                    )
                  : const Text(''),
            ],
          ),
        )
      ],
    );
  }
}

class _TitleAndInfo extends StatelessWidget {
  final String title;
  final String value;

  const _TitleAndInfo({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Color(0xff25396F),
              fontSize: 15,
              fontFamily: 'NotoSans',
              fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Color(0xff25396F), fontSize: 15, fontFamily: 'NotoSans'),
        )
      ],
    );
  }
}
