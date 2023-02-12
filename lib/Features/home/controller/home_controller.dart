import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/special_day/view/widgets/special_drawer.dart';

import '../../../main.dart';

class HomeController extends GetxController {
  var tokenGlobal;
  late int userId;
  late String tokens;

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    print("token::::::::$getTOken");
     tokenGlobal = getTOken;
    return getTOken;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user-id');
    print('User id from controller $userId');
    return userId;
  }
}
