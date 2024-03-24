import 'dart:math';

class RandomWord {
  static String getRandomWord() {
    const String alphaNumeric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String randomWord = "";
    final random = Random();
    int randomLength = (random.nextInt(5) + 1) + 5;
    int length = alphaNumeric.length;
    for (int i = 0; i < randomLength; i++) {
      randomWord += alphaNumeric[random.nextInt(length)];
    }

    return randomWord;
  }
}
