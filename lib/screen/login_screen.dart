import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';
import '../providers/auth_service.dart';
import '../widgets/index.dart';
import '../global/validations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [_Logo(), _Form(), _Labels()],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: const [
            Image(image: AssetImage('assets/salud.png')),
            SizedBox(height: 20),
            Text(
              'Salud',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: authService.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomInput(
              icon: Icons.mail_outline,
              placeHolder: 'Correo',
              labelText: const Text('Correo'),
              keyboadType: TextInputType.emailAddress,
              onChanged: (value) => authService.email = value!,
              validator: (value) {
                String pattern = Validations.patternEmail;
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El correo no es valido';
              },
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeHolder: 'Contraseña',
              keyboadType: TextInputType.emailAddress,
              isPassword: authService.isObscure,
              labelText: const Text('Contraseña'),
              suffixIcon: IconButton(
                  icon: Icon(authService.isObscure
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    authService.isObscure = !authService.isObscure;
                  }),
              onChanged: (value) => authService.password = value!,
              validator: (value) {
                return (value?.trim().isNotEmpty == true)
                    ? null
                    : 'La contraseña es requedida';
              },
            ),
            CustomButton(
                color: Theme.of(context).primaryColor,
                text: 'Ingresar',
                onPressed: authService.authenticating
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!authService.isValidForm()) return;

                        final loginStatus = await authService.login(
                            authService.email.trim(),
                            authService.password.trim());

                        if (loginStatus) {
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          if (!mounted) return;
                          showAlert(
                              context, 'Error', 'Compruebe sus credenciales');
                        }
                      })
          ],
        ),
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Info')],
    );
  }
}
