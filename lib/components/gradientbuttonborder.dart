import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BorderGradientButton extends StatelessWidget {
  final String label;
  final Function handleOnPressed;
  final double fontSize;
  final double padding;

  const BorderGradientButton(
      {super.key,
      required this.label,
      required this.handleOnPressed,
      this.fontSize = 27,
      this.padding = 30,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
          width: padding != 0 ? double.maxFinite : double.infinity,
          decoration: BoxDecoration(
              border: const GradientBoxBorder(
                gradient: customGradient,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(7)),
          child: MaterialButton(
            onPressed: () => handleOnPressed(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: GradientText(
                text: label,
                textSize: fontSize,
              ),
            ),
          )),
    );
  }
}
