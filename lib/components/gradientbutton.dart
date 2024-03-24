import 'package:compilation/util.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final Function handleOnTap;
  final bool maxLength;
  final bool putIcon;

  const GradientButton(
      {Key? key,
      required this.label,
      required this.handleOnTap,
      this.maxLength = false,
      this.putIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () => handleOnTap(),
      child: Ink(
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: customGradient,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: putIcon
              ? const Icon(
                  Icons.play_arrow_sharp,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  size: 40,
                )
              : Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
