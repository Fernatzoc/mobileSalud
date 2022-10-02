import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/validations.dart';
import '../helpers/show_alert.dart';
import '../providers/user_service.dart';
import '../widgets/index.dart';

class CreateUserScreen extends StatelessWidget {
  const CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [_Form()],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
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
              icon: Icons.lock_outline,
              placeHolder: 'Contraseña',
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
              validator: (value) {
                return (value?.trim().isNotEmpty == true)
                    ? null
                    : 'La contraseña es requedida';
              },
            ),
            CustomButton(
              color: Theme.of(context).primaryColor,
              text: 'Guardar',
              onPressed: userService.creatingUser
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!userService.isValidForm()) return;

                      final userCreateStatus = await userService.createUser(
                        userService.name.trim(),
                        userService.email.trim(),
                        userService.role.trim(),
                        userService.password.trim(),
                      );
                      if (userCreateStatus) {
                        if (!mounted) return;
                        Fluttertoast.showToast(
                            msg: "Usuario Creado Correctamente",
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
                    },
            )
          ],
        ),
      ),
    );
  }
}
