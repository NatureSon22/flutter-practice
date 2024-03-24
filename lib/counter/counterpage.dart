import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/counter/counter.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';

import 'buttonfield.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  Duration duration = const Duration(hours: 0, minutes: 0, seconds: 0);
  List<int> time = [0, 0, 0];
  String selected = '';

   void onSelectedChange(String newSelected) {
    setState(() {
      selected = newSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Image.asset(
                'assets/image/group5.png',
                width: 50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const GradientText(text: 'captcha typing', textSize: 22),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 5,
        shadowColor: appBarShadow,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [
                  GradientText(text: 'timer', textSize: 40),
                  GradientText(text: 'group 3', textSize: 20)
                ],
              ),
              const SizedBox(
                height: 160,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Counter(
                      label: 'HR',
                      duration: duration,
                      time: time,
                      selected: onSelectedChange,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Counter(
                        label: 'MIN',
                        duration: duration,
                        time: time,
                        selected: onSelectedChange),
                    const SizedBox(
                      width: 40,
                    ),
                    Counter(
                        label: 'SEC',
                        duration: duration,
                        time: time,
                        selected: onSelectedChange)
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ButtonField(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}
