import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../models/index.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class UpdateRegisterScreen extends StatelessWidget {
  const UpdateRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Pregnant pregnant =
        ModalRoute.of(context)!.settings.arguments as Pregnant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Registro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _FormPregnant(
              pregnant: pregnant,
            )
          ],
        ),
      ),
    );
  }
}

class _FormPregnant extends StatefulWidget {
  final Pregnant pregnant;

  const _FormPregnant({Key? key, required this.pregnant}) : super(key: key);

  @override
  State<_FormPregnant> createState() => _FormPregnantState();
}

class _FormPregnantState extends State<_FormPregnant> {
  final namesController = TextEditingController();
  final lastnamesController = TextEditingController();
  final cuiController = TextEditingController();
  final addressController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final examTypeController = TextEditingController();
  final lastRuleController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final cmbController = TextEditingController();

  @override
  void initState() {
    namesController.text = widget.pregnant.nombres;
    lastnamesController.text = widget.pregnant.apellidos;
    cuiController.text = widget.pregnant.cui;
    addressController.text = widget.pregnant.direccion;
    dateOfBirthController.text = widget.pregnant.fechaDeNacimiento;
    examTypeController.text = widget.pregnant.tipoDeExamen;
    lastRuleController.text = widget.pregnant.ultimaRegla;
    weightController.text = widget.pregnant.peso;
    heightController.text = widget.pregnant.altura;
    cmbController.text = widget.pregnant.cmb;

    super.initState();
  }

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
                controller: namesController,
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
                controller: lastnamesController,
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
                controller: cuiController,
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
                controller: addressController,
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
                initialValue: dateOfBirthController.text,
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
                // onChanged: (value) => pregnancyService.dateOfBirth = value,
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
              child: DropdownButtonFormField(
                value: widget.pregnant.tipoDeExamen,
                items: const [
                  DropdownMenuItem(
                    value: 'Ultima Regla',
                    child: Text('Ultima Regla'),
                  ),
                  DropdownMenuItem(
                    value: 'Usg',
                    child: Text('USG'),
                  )
                ],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.app_registration_outlined),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    label: Text('Tipo de examen'),
                    hintText: 'Tipo de examen'),
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El tipo de examen es requerido';
                },
                onChanged: (String? value) =>
                    pregnancyService.examType = value!,
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
                controller: lastRuleController,
                firstDate: DateTime(DateTime.now().year,
                    DateTime.now().month - 9, DateTime.now().day),
                lastDate: DateTime.now(),
                dateLabelText: 'Fecha',
                confirmText: 'Aceptar',
                cancelText: 'Cancelar',
                calendarTitle: 'Seleccione Fecha',
                decoration: const InputDecoration(
                  hintText: 'Fecha',
                  focusedBorder: InputBorder.none,
                  label: Text('Fecha'),
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: InputBorder.none,
                ),
                // onChanged: (value) => pregnancyService.lastRule = value,
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
                controller: weightController,
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
                controller: heightController,
                keyboadType: TextInputType.number,
                onChanged: (value) => pregnancyService.height = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo altura es requerido';
                }),
            CustomInput(
                icon: Icons.perm_identity_outlined,
                placeHolder: 'Cmb',
                labelText: const Text('Cmb'),
                controller: cmbController,
                keyboadType: TextInputType.number,
                onChanged: (value) => pregnancyService.cmb = value!,
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El campo altura es requerido';
                }),
            CustomButton(
                color: Theme.of(context).primaryColor,
                text: 'Actualizar',
                onPressed: pregnancyService.creatingPregnant
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!pregnancyService.isValidForm()) return;

                        final pregnantCreateStatus =
                            await pregnancyService.updatePregnant(
                                widget.pregnant.id.toString(),
                                namesController.text.trim(),
                                lastnamesController.text.trim(),
                                cuiController.text.trim(),
                                addressController.text.trim(),
                                dateOfBirthController.text.trim(),
                                widget.pregnant.tipoDeExamen.trim(),
                                lastRuleController.text.trim(),
                                weightController.text.trim(),
                                heightController.text.trim(),
                                cmbController.text.trim());

                        if (pregnantCreateStatus) {
                          if (!mounted) return;
                          Fluttertoast.showToast(
                              msg: "Registro Actualizado Correctamente",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xff6A7AFA),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
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
