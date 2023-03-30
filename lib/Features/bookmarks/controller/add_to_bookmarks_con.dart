import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/api_link.dart';

class AddtoBookmarksController extends GetxController {
  addToBookmarks(
      int userid, int productId, String type, String textToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');

      http.Response response = await http
          .post(Uri.parse(Appurl.baseURL+'api/add-to-bookmark'), body: {
        'user_id': userid.toString(),
        'product_id': productId.toString(),
        'type': type.toString(),
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return data['message'];
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
