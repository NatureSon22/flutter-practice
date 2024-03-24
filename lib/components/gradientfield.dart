import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../util.dart';

class GradientTextField extends StatelessWidget {
  final Function onChanged;
  final TextEditingController? controller;
  final bool showPassword;
  final Function setShowPassword;
  final IconData? icon;

  const GradientTextField({
    Key? key,
    required this.onChanged,
    this.controller,
    this.showPassword = false,
    this.setShowPassword = _defaultSetShowPassword,
    this.icon,
  }) : super(key: key);

  static _defaultSetShowPassword() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: GradientBoxBorder(gradient: customGradient, width: 2.5),
      ),
      child: TextField(
        textAlignVertical: icon != null ? TextAlignVertical.center : TextAlignVertical.top,
        controller: controller,
        onChanged: (value) => onChanged(value),
        obscureText: showPassword,
        decoration: InputDecoration(
          suffixIcon: icon != null
              ? IconButton(
                  icon: Icon(icon, color: iconColor,),
                  onPressed: () => setShowPassword(),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}

