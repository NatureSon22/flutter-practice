import 'dart:async';
import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/main.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class TimerConsumer extends ConsumerWidget {
  const TimerConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final val = ref.watch(timeStateProvider);
    return TimerPage(val: val);
  }
}




class TimerPage extends StatefulWidget {
  final Duration initialDuration;
  final Map<String, int> val;

  const TimerPage({
    super.key,
    this.initialDuration = const Duration(minutes: 2),
    required this.val
  });

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Duration _duration = Duration.zero;
  Timer? _timer;
  double _progress = 1.0;
  bool _isPaused = false;

  @override
  void initState() {
    _duration = Duration(hours: widget.val['HR']!, minutes: widget.val['MIN']!, seconds: widget.val['SEC']!);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void subtractTime() {
    if (_duration.inSeconds > 0 && !_isPaused) {
      setState(() {
        final seconds = _duration.inSeconds - 1;
        _duration = Duration(seconds: seconds);
        _progress -= 1 / _duration.inSeconds;
      });
    } else {
      _timer?.cancel();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => subtractTime());
  }

  void resetTimer() {
    setState(() {
      _duration = widget.initialDuration;
      _progress = 1.0;
      _timer?.cancel();
      startTimer();
    });
  }


  void pauseTimer() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _timer?.cancel();
      } else {
        startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        '${_duration.inHours.toString().padLeft(2, '0')}:${_duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${_duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/group5.png',
                width: 80,
              ),
              const GradientText(text: 'timer', textSize: 30),
              const SizedBox(height: 150,),
              FractionallySizedBox(
                widthFactor:
                    0.8, // Adjust width factor as needed (0.8 for example)
                child: Container(
                  height: 200.0, // Adjust height as needed
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 200,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 1.3,
                          child: CircularProgressIndicator(
                            value: _progress,
                            strokeWidth: 10.0,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                deepBlue),
                          ),
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: const TextStyle(
                            fontSize: 32.0, color: brightBlue),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(10),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white)),
                        onPressed: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: brightBlue,
                          ),
                        )),
                    ElevatedButton(
                        onPressed: pauseTimer,
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(10),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Icon(
                            _isPaused ? Icons.play_arrow : Icons.pause,
                            size: 35,
                            color: deepBlue,
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
