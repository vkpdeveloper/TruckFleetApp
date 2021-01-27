import 'package:flutter/widgets.dart';
import 'package:flutter_learning_app/controllers/http_controller.dart';
import 'package:flutter_learning_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user;

  init() async {
    user = await HttpController.getUserProfile();
    notifyListeners();
  }
}
