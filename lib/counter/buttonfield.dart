import 'package:compilation/components/gradientbutton.dart';
import 'package:compilation/counter/timerpage.dart';
import 'package:compilation/main.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonField extends ConsumerWidget {
  final String selected;
  const ButtonField({super.key, required this.selected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
                onPressed: () {
                  ref
                      .read(timeStateProvider.notifier)
                      .update((state) => {'HR': 0, 'MIN': 0, 'SEC': 0});
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(10),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: 
                  FaIcon(FontAwesomeIcons.arrowsRotate, color: brightBlue,),
                )),
            ElevatedButton(
                onPressed: () {
                  ref.read(timeStateProvider.notifier).update(
                      (state) => {...state, selected: state[selected]! + 1});
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(10),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: FaIcon(FontAwesomeIcons.plus, color: deepBlue,),
                )),
            ElevatedButton(
                onPressed: () {
                  ref.read(timeStateProvider.notifier).update((state) => {
                        ...state,
                        selected:
                            state[selected]! > 0 ? state[selected]! - 1 : 0
                      });
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(10),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: FaIcon(FontAwesomeIcons.minus, color: deepBlue,),
                )),
          ]),
          const SizedBox(
            height: 30,
          ),
          Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GradientButton(
                  label: '',
                  putIcon: true,
                  handleOnTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TimerConsumer())))),
        ],
      ),
    );
  }
}
