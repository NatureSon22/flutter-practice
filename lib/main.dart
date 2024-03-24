import 'package:compilation/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeStateProvider =
    StateProvider<Map<String, int>>((ref) => {'HR': 0, 'MIN': 0, 'SEC': 0});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SafeArea(child: Login()),
      builder: EasyLoading.init(),
    );
  }
}
