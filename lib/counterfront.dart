import 'package:compilation/captcha_app/captcha.dart';
import 'package:flutter/material.dart';

class CounterFront extends StatelessWidget {
  const CounterFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Hero(
            tag: 'hero-rectangle',
            child: Container(
              color: Colors.red,
              height: 400,
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push( context, MaterialPageRoute(builder: (context) => const CaptchaBody(),));
          }, child: const Text('GO TO COUNTER'))
        ],
      ),
    );
  }
}
