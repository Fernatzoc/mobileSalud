import 'package:flutter/material.dart';
import 'package:mobile_salud/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../helpers/show_alert.dart';
import '../widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
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
  final emailCotroller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyboadType: TextInputType.emailAddress,
            textcontroller: emailCotroller,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            keyboadType: TextInputType.emailAddress,
            textcontroller: passwordController,
            isPassword: true,
          ),
          CustomButton(
            color: Colors.blue,
            text: 'Ingresar',
            onPressed: authService.authenticating
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    final loginStatus = await authService.login(
                        emailCotroller.text.trim(),
                        passwordController.text.trim());

                    if (loginStatus) {
                      if (!mounted) return;
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      if (!mounted) return;
                      showAlert(context, 'asd', 'asdd');
                    }
                  },
          )
        ],
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
