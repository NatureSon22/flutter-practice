import 'dart:convert';
import 'package:compilation/captcha_app/word.dart';
import 'package:compilation/components/gradientbutton.dart';
import 'package:compilation/components/gradientbuttonborder.dart';
import 'package:compilation/components/gradienttext.dart';
import 'package:compilation/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class CaptchaBody extends StatefulWidget {
  const CaptchaBody({super.key});

  @override
  State<CaptchaBody> createState() => _CaptchaBodyState();
}

class _CaptchaBodyState extends State<CaptchaBody> {
  String imageUrl = "";
  String captchaWord = "";
  TextEditingController textController = TextEditingController();

  void checkUserInput() {
    if (captchaWord.isEmpty) {
      _showSnackBar('Get a key first!');
      return;
    }

    if (textController.text.isEmpty) {
      _showSnackBar('Input code is required!');
      return;
    }

    bool isCorrect = captchaWord == textController.text;
    Map<String, String> dialogDetails = isCorrect
        ? {
            "title": "congratulations!",
            "sub-message": "You input a correct code!",
            "animation": 'assets/animation/confetti.json'
          }
        : {
            "title": "invalid code!",
            "sub-message": "Please, try again",
            "animation": 'assets/animation/sadface.json'
          };

    _showMyDialog(dialogDetails, isCorrect);
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Center(child: Text(message)),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showMyDialog(Map<String, String> dialogDetails, bool isCorrect) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return bodyAlertDialog(dialogDetails, isCorrect);
      },
    );
  }

  Widget bodyAlertDialog(Map<String, String> dialogDetails, bool isCorrect) {
    if (isCorrect) {
      return AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 50),
        content: Container(
          height: 270,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Lottie.asset(dialogDetails['animation']!,
                  width: 500, height: 200),
              Positioned(
                top: 20,
                child: Column(
                  children: [
                    GradientText(text: dialogDetails['title']!, textSize: 30),
                    Text(
                      dialogDetails['sub-message']!,
                      style: const TextStyle(
                          color: brightBlue,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: BorderGradientButton(
                  label: 'ok',
                  handleOnPressed: () {
                    if (isCorrect) {
                      setState(() {
                        imageUrl = "";
                      });
                    }
                    textController.clear();
                    Navigator.of(context).pop();
                  },
                  fontSize: 25,
                  padding: 60,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
       return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 70),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Lottie.asset(
                    dialogDetails['animation']!,
                    width: 200,
                  ),
                  Positioned(
                    bottom: -20,
                    child: Column(
                      children: [
                        GradientText(
                            text: dialogDetails['title']!, textSize: 35),
                        Text(
                          dialogDetails['sub-message']!,
                          style: const TextStyle(
                              color: brightBlue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              BorderGradientButton(
                  label: 'ok',
                  handleOnPressed: () {
                    textController.clear();
                    Navigator.of(context).pop();
                  },
                  fontSize: 25,
                  padding: 40,
                  ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
    }
  }

  Future<void> _getImageUrl() async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    while (true) {
      captchaWord = RandomWord.getRandomWord();

      try {
        final url =
            'https://captcha-generator.p.rapidapi.com/?text=$captchaWord&noise_number=10&fontname=sora';
        const apiKey = '089a375889msh9a6ad90ff7acc20p1e31e9jsn9fb3e9157935';
        const headers = {
          'X-RapidAPI-Key': apiKey,
          'X-RapidAPI-Host': 'captcha-generator.p.rapidapi.com',
        };

        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            imageUrl = data['image_url'];
          });
          break; // Break the loop if successful
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        EasyLoading.dismiss();
        textController.clear();
      }
    }
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
              Image.asset(
                'assets/image/group5.png',
                width: 80,
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                color: lightGrey,
                height: 120,
                child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: imageUrl.isNotEmpty
                        ? imageUrl.isEmpty
                            ? const SizedBox()
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.fill,
                              )
                        : const Center(
                            child: Text(
                            'Generate captcha',
                            style: TextStyle(color: midGrey),
                          ))),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  'group 3',
                  style: TextStyle(
                      color: brightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Column(
                  children: [
                    CaptchaInput(
                      controller: textController,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GradientButton(
                      label: 'submit captcha',
                      handleOnTap: checkUserInput,
                      maxLength: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BorderGradientButton(
                      label:
                          imageUrl.isEmpty ? "get key" : "generate another key",
                      handleOnPressed: _getImageUrl,
                      fontSize: 20,
                      padding: 0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CaptchaInput extends StatelessWidget {
  final TextEditingController controller;

  const CaptchaInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'enter code here',
          style: TextStyle(
              color: brightBlue, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            Container(
              height: 3.5,
              decoration: const BoxDecoration(gradient: customGradient),
            )
          ],
        ),
      ],
    );
  }
}
