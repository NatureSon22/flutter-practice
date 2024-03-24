import 'package:compilation/util.dart';
import 'package:flutter/cupertino.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double textSize;
  const GradientText({super.key, required this.text, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => customGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: textSize),
      ),
    );
  }
}
