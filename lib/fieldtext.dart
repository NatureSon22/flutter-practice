import 'package:compilation/components/gradientfield.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';

class FieldText extends StatefulWidget {
  final bool showPassword;
  final Function setShowPassword;
  final Function setUsername;
  final Function setPassword;
  final TextEditingController passwordController;

  const FieldText(
      {super.key,
      required this.showPassword,
      required this.setShowPassword,
      required this.setUsername,
      required this.setPassword,
      required this.passwordController});

  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'username',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: brightBlue),
              ),
              const SizedBox(
                height: 10,
              ),
              GradientTextField(onChanged: widget.setUsername)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: brightBlue),
              ),
              const SizedBox(
                height: 10,
              ),
              GradientTextField(
                onChanged: widget.setPassword,
                controller: widget.passwordController,
                showPassword: widget.showPassword,
                setShowPassword: widget.setShowPassword,
                icon: Icons.remove_red_eye,
              )
            ],
          ),
        ),
      ],
    );
  }
}
