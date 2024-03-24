import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/useraccount.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';

import 'fieldtext.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = true;
  String username = "";
  String password = "";
  TextEditingController passwordController = TextEditingController();
  bool logInClicked = false;

  void _setShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  bool checkFieldEmpty() {
    if (username.isEmpty) {
      _showSnackBar('Username is required');
      return true;
    }

    if (password.isEmpty) {
      _showSnackBar('Password is required');
      return true;
    }

    return false;
  }

  Future<void> _checkAccount() async {

    if (username == "GROUP3" && password == "GROUP3") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserAccount()),
      );
    } else {
      _showMyDialog(context);
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const GradientText(
            text: 'Login Error',
            textSize: 25,
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Invalid Username or Password! Please try again.',  style: TextStyle(color: brightBlue, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                passwordController.clear();
                password = "";
              },
            ),
          ],
        );
      },
    );
  }

  void _setUsername(String username) {
    this.username = username;
  }

  void _setPassword(String password) {
    this.password = password;
  }

  void _setlogInClicked() async {
    if (checkFieldEmpty()) return;

    setState(() {
      // Toggle showPassword immediately
      logInClicked = !logInClicked;

      if (logInClicked) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            logInClicked = false;
          });

          _checkAccount();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const GradientText(text: 'sign in to your account', textSize: 22),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 5,
        shadowColor: appBarShadow,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/image/group5.png',
                width: 250,
              ),
              const GradientText(text: 'test.io', textSize: 25),
              const SizedBox(
                height: 90,
              ),
              FieldText(
                showPassword: showPassword,
                setShowPassword: _setShowPassword,
                setUsername: _setUsername,
                setPassword: _setPassword,
                passwordController: passwordController,
              ),
              const SizedBox(
                height: 50,
              ),
              !logInClicked
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MaterialButton(
                        onPressed: () => _setlogInClicked(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Ink(
                              decoration: const BoxDecoration(
                                gradient: customGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                child: Text('login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )),
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
