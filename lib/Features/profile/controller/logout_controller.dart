import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/sub_category_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';
import '../models/logout_model.dart';

class LogoutController extends GetxController {
  Future<String?> logout(String textToken) async {
    try {
      print('token = $textToken');
      var url = Appurl.baseURL + "api/logout";

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final marketCategory = logoutFromJson(response.body);
        print(marketCategory.message);
        return marketCategory.message;
      } else {
        print('Logout Error');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
