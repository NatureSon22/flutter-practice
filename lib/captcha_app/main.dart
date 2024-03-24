import 'package:compilation/captcha_app/captcha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CaptchaApp extends StatelessWidget {
  const CaptchaApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const CaptchaBody(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
