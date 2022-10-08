import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class CreateRegisterScreen extends StatelessWidget {
  const CreateRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Registro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [_FormPregnant()],
        ),
      ),
    );
  }
}

class _FormPregnant extends StatefulWidget {
  const _FormPregnant({Key? key}) : super(key: key);

  @override
  State<_FormPregnant> createState() => _FormPregnantState();
}

class _FormPregnantState extends State<_FormPregnant> {
  @override
  Widget build(BuildContext context) {
    final pregnancyService = Provider.of<PregnancyService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: pregnancyService.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomInput(
                icon: Icons.person_outline,
                placeHolder: 'Nombres',
                labelText: const Text('Nombres'),
                keyboadType: TextInputType.name,
                onChanged: (value) => pregnancyService.names = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo nombres es requerido';
                }),
            CustomInput(
                icon: Icons.person_outline,
                placeHolder: 'Apellidos',
                labelText: const Text('Apellidos'),
                keyboadType: TextInputType.name,
                onChanged: (value) => pregnancyService.lastNames = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo apellidos es requerido';
                }),
            CustomInput(
                icon: Icons.perm_identity_outlined,
                placeHolder: 'Cui',
                labelText: const Text('Cui'),
                keyboadType: TextInputType.number,
                onChanged: (value) => pregnancyService.cui = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo cui es requerido';
                }),
            CustomInput(
                icon: Icons.home_outlined,
                placeHolder: 'Dirección',
                labelText: const Text('Dirección'),
                keyboadType: TextInputType.text,
                onChanged: (value) => pregnancyService.address = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo dirección es requerido';
                }),
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
                firstDate: DateTime(1950),
                lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
                dateLabelText: 'Fecha de Nacimiento',
                confirmText: 'Aceptar',
                cancelText: 'Cancelar',
                calendarTitle: 'Seleccione Fecha',
                decoration: const InputDecoration(
                  hintText: 'Fecha de nacimiento',
                  focusedBorder: InputBorder.none,
                  label: Text('Fecha de nacimiento'),
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: InputBorder.none,
                ),
                onChanged: (value) => pregnancyService.dateOfBirth = value,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo cui es requerido';
                },
              ),
            ),
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
                firstDate: DateTime(DateTime.now().year,
                    DateTime.now().month - 9, DateTime.now().day),
                lastDate: DateTime.now(),
                dateLabelText: 'Ultima regla',
                confirmText: 'Aceptar',
                cancelText: 'Cancelar',
                calendarTitle: 'Seleccione Fecha',
                decoration: const InputDecoration(
                  hintText: 'Ultima regla',
                  focusedBorder: InputBorder.none,
                  label: Text('Ultima regla'),
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: InputBorder.none,
                ),
                onChanged: (value) => pregnancyService.lastRule = value,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo cui es requerido';
                },
              ),
            ),
            CustomInput(
                icon: Icons.perm_identity_outlined,
                placeHolder: 'Peso en Libras',
                labelText: const Text('Peso en Libras'),
                keyboadType: TextInputType.number,
                onChanged: (value) => pregnancyService.weight = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo peso es requerido';
                }),
            CustomInput(
                icon: Icons.perm_identity_outlined,
                placeHolder: 'Altura',
                labelText: const Text('Altura'),
                keyboadType: TextInputType.number,
                onChanged: (value) => pregnancyService.height = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo altura es requerido';
                }),
            CustomButton(
                color: Theme.of(context).primaryColor,
                text: 'Guardar',
                onPressed: pregnancyService.creatingPregnant
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!pregnancyService.isValidForm()) return;

                        final pregnantCreateStatus =
                            await pregnancyService.createPregnant(
                                pregnancyService.names.trim(),
                                pregnancyService.lastNames.trim(),
                                pregnancyService.cui.trim(),
                                pregnancyService.address.trim(),
                                pregnancyService.dateOfBirth.trim(),
                                pregnancyService.lastRule.trim(),
                                pregnancyService.weight.trim(),
                                pregnancyService.height.trim());

                        if (pregnantCreateStatus) {
                          if (!mounted) return;
                          Fluttertoast.showToast(
                              msg: "Registro Creado Correctamente",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xff6A7AFA),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        } else {
                          if (!mounted) return;
                          showAlert(context, 'Error', 'Compruebe sus datos');
                        }
                      })
          ],
        ),
      ),
    );
  }
}
