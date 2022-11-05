import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/validations.dart';
import '../helpers/show_alert.dart';
import '../providers/index.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        width: double.infinity,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: const [
            Image(image: AssetImage('assets/salud.png')),
            SizedBox(height: 20),
            Text(
              'Recuperar Contraseña',
              style: TextStyle(fontSize: 30, fontFamily: 'NotoSans'),
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
      // margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: authService.formKeyForgotPasword,
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
            CustomButton(
                color: Theme.of(context).primaryColor,
                text: 'Enviar',
                onPressed: authService.authenticating
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        if (!authService.isValidFormForgot()) return;

                        final loginStatus = await authService.forgotPassword(
                          authService.email.trim(),
                        );

                        if (loginStatus) {
                          if (!mounted) return;
                          showAlert(context, 'Mensaje',
                              'Revise su bandeja de entrada');
                        } else {
                          if (!mounted) return;
                          showAlert(
                              context, 'Error', 'Error usuario no encontrado');
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
      children: [
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          child: const Text('Iniciar Secion',
              style: TextStyle(color: Color(0xff6A7AFA))),
        ),
        const SizedBox(height: 40),
        const Image(
          image: AssetImage('assets/umg.png'),
          fit: BoxFit.contain,
          width: 100,
        ),
        const Text('UMG'),
      ],
    );
  }
}
