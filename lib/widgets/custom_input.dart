import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textcontroller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType keyboadType;
  final bool isPassword;

  const CustomInput({
    Key? key,
    required this.icon,
    required this.placeHolder,
    required this.textcontroller,
    required this.validator,
    this.keyboadType = TextInputType.text,
    this.isPassword = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
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
      child: TextFormField(
          controller: textcontroller,
          autocorrect: false,
          keyboardType: keyboadType,
          obscureText: isPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: placeHolder,
              suffixIcon: suffixIcon),
          validator: validator),
    );
  }
}
