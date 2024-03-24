import 'package:compilation/components/gradienttext.dart';
import 'package:flutter/material.dart';

class IntroButton extends StatelessWidget {
  final String text;
  final String image;
  final Widget page;
  const IntroButton(
      {super.key, required this.text, required this.image, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (conntext) => page));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35.0, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/$image.png',
                  width: 130,
                ),
                GradientText(text: text, textSize: 22)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
