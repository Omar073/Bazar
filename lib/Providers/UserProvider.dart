import 'package:flutter/cupertino.dart';

import '../Classes/User.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  UserProvider({
    User? user, // Change parameter name to 'user'
  }) : this.user = user ?? User(uid: '', Fname: '', Sname: '', email: '', password: '');

  void changeCurrentUser({
    required User newUser,
  }) {
    user = newUser;
    notifyListeners();
  }
}
