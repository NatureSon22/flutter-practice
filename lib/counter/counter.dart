import 'package:compilation/main.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StatefulWidget {
  final String label;
  final Duration duration;
  final List<int> time;
  final Function selected;

  const Counter({Key? key, required this.label, required this.duration, required this.time, required this.selected}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late TextEditingController _controller;
  int time = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer (
      builder: (BuildContext context, WidgetRef ref, Widget? child) { 
        int? val;

        ref.listen<Map<String, int>>(timeStateProvider, (prev, next) {
          val = next[widget.label]; // Access value for the label
          _controller.text = val.toString(); // Update TextField text
        });

        return Expanded(
        child: TextField(
          inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
              LimitRangeTextInputFormatter(0, widget.label == 'HR' ? 24 : 60),
          ],
          controller: _controller,
          style: const TextStyle(fontSize: 20, color: deepBlue),
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          onTap: () => widget.selected(widget.label),
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFAEABBF)),
            ),
            labelStyle: const TextStyle(
              color: Color(0xFFAEABBF),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFAEABBF)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFAEABBF)),
            ),
          ),
          onChanged: (String value) {
            ref.read(timeStateProvider.notifier).update((state) => state..update(widget.label, (value) => int.parse(_controller.text)));
            ref.watch(timeStateProvider);
          },
        ),
      );
 },
      );
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max, {this.defaultIfEmpty = false})
      : assert(min < max);

  final int min;
  final int max;
  final bool defaultIfEmpty;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int value = int.tryParse(newValue.text) ?? 0;
    String enforceValue;

    // Check if value is within the specified range
    if (value < min) {
      // Value is less than the minimum, set to minimum
      enforceValue = min.toString();
    } else if (value > max) {
      // Value is greater than the maximum, set to maximum
      enforceValue = max.toString();
    } else {
      // Value is within the range
      enforceValue = value.toString();
    }

    // Set default value if input is empty
    if (enforceValue.isEmpty && defaultIfEmpty) {
      enforceValue = min.toString();
    }

    // Return updated text editing value
    return TextEditingValue(
      text: enforceValue,
      selection: TextSelection.collapsed(offset: enforceValue.length),
    );
  }
}

