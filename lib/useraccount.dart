import 'package:compilation/captcha_app/captcha.dart';
import 'package:compilation/components/gradientbuttonborder.dart';
import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/components/introbutton.dart';
import 'package:compilation/counter/counterpage.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  const UserAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/image/group5.png',
              width: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            const GradientText(text: 'hello group 3', textSize: 22),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 5,
        shadowColor: appBarShadow,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const GradientText(text: 'project compilation', textSize: 30),
          const Padding(
            padding: EdgeInsets.only(top: 50, bottom: 0),
            child: Column(
              children: [
                IntroButton(
                    text: 'increment / decrement',
                    image: 'timer_crop',
                    page: CounterPage()),
                SizedBox(
                  height: 20,
                ),
                IntroButton(
                    text: 'captcha typing',
                    image: 'captcha_crop',
                    page: CaptchaBody()),
              ],
            ),
          ),
          BorderGradientButton(
              label: 'logout',
              handleOnPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
