import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_salud/models/index.dart';
import 'package:provider/provider.dart';

import '../global/validations.dart';
import '../helpers/show_alert.dart';
import '../providers/index.dart';
import '../widgets/index.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_Form(user: user)],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final User user;

  const _Form({Key? key, required this.user}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  final estadoController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user.name!;
    emailController.text = widget.user.email!;
    estadoController.text = widget.user.estado ?? '1';
    roleController.text = widget.user.rol!;
    passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: userService.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomInput(
              icon: Icons.person_outline,
              placeHolder: 'Nombre',
              labelText: const Text('Nombre'),
              controller: nameController,
              keyboadType: TextInputType.name,
              onChanged: (value) => userService.name = value!,
              validator: (value) {
                return (value?.trim().isNotEmpty == true)
                    ? null
                    : 'El nombre es requerido';
              },
            ),
            CustomInput(
              icon: Icons.mail_outline,
              placeHolder: 'Correo',
              labelText: const Text('Correo'),
              controller: emailController,
              keyboadType: TextInputType.emailAddress,
              onChanged: (value) => userService.email = value!,
              validator: (value) {
                String pattern = Validations.patternEmail;
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es valido';
              },
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
                value: widget.user.estado ?? '1',
                items: const [
                  DropdownMenuItem(
                    value: '1',
                    child: Text('Activo'),
                  ),
                  DropdownMenuItem(
                    value: '0',
                    child: Text('Inactivo'),
                  )
                ],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.admin_panel_settings_outlined),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    label: Text('Estado'),
                    hintText: 'Estado'),
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El estado es requerido';
                },
                onChanged: (String? value) => userService.state = value!,
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
                value: widget.user.rol,
                items: const [
                  DropdownMenuItem(
                    value: 'Administrador',
                    child: Text('Administrador'),
                  ),
                  DropdownMenuItem(
                    value: 'Personal',
                    child: Text('Personal'),
                  )
                ],
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.admin_panel_settings_outlined),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    label: Text('Rol'),
                    hintText: 'Rol'),
                validator: (value) {
                  return (value?.trim().isNotEmpty == true)
                      ? null
                      : 'El rol es requerido';
                },
                onChanged: (String? value) => userService.role = value!,
              ),
            ),
            CustomInput(
              controller: passwordController,
              icon: Icons.lock_outline,
              placeHolder: 'Contraseña',
              labelText: const Text('Contraseña'),
              keyboadType: TextInputType.emailAddress,
              isPassword: userService.isObscure,
              suffixIcon: IconButton(
                  icon: Icon(userService.isObscure
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    userService.isObscure = !userService.isObscure;
                  }),
              onChanged: (value) => userService.password = value!,
            ),
            CustomButton(
              color: Theme.of(context).primaryColor,
              text: 'Actualizar',
              onPressed: userService.creatingUser
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!userService.isValidForm()) return;

                      late String role;
                      late String state;

                      if (userService.role == "") {
                        role = roleController.text.trim();
                      } else {
                        role = userService.role;
                      }

                      if (userService.state == "") {
                        state = estadoController.text.trim();
                      } else {
                        state = userService.state;
                      }

                      final userCreateStatus = await userService.updateUser(
                          nameController.text.trim(),
                          emailController.text.trim(),
                          role,
                          state,
                          passwordController.text.trim(),
                          widget.user.id.toString().trim());
                      if (userCreateStatus) {
                        if (!mounted) return;
                        Fluttertoast.showToast(
                            msg: "Usuario Actualizado Correctamente",
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
                    },
            )
          ],
        ),
      ),
    );
  }
}
