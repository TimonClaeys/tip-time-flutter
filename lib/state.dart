import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  bool roundUp = false;

  double billAmount = 0;
  double tipAmount = 0;

  switchRoundUp(bool value) {
    roundUp = value;
    notifyListeners();
  }

  setBillAmount(double? amount) {
    if (amount != null) {
      billAmount = amount;
      notifyListeners();
    }
  }

  setTipAmount(double? amount) {
    if (amount != null) {
      tipAmount = amount;
      notifyListeners();
    }
  }

  String getTipAmount() {
    if (billAmount == 0.0) {
      return '0.0';
    }

    final tip = billAmount * (tipAmount / 100);

    if (roundUp) {
      return tip.ceil().toString();
    }
    return ((tip * 100).roundToDouble() / 100).toString();
  }
}
