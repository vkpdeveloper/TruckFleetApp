import 'dart:io';

import 'package:flutter/widgets.dart';

class LoginProvider extends ChangeNotifier {
  String phone;
  String email;
  String name;
  String companyName;
  String location;

  File aadhaar;
  File pan;

  setAadhaar(card) {
    aadhaar = card;
    notifyListeners();
  }

  setPan(card) {
    pan = card;
    notifyListeners();
  }

  setInfo(e, n, cN, loc) {
    email = e;
    name = n;
    companyName = cN;
    location = loc;
    notifyListeners();
  }
}
