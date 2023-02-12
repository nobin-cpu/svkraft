import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/profile/models/get_profile_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';
import '../models/user_profile_model.dart';

class GetProfileController extends GetxController {
  var userProfileModel = UserProfileModel().obs;
  var isLoading = false.obs;

  Future<GetProfileDetailsData?> getProfile(String textToken) async {
    try {
      print('profileeeeeeeeee $textToken');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      var url = Appurl.baseURL + "api/profile";

      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        isLoading=true.obs;
        final allProduct = getProfileDetailsFromJson(response.body);

        return allProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

  getUserProfile(String textToken) async {

    try {
    update();
      print('profileeeeeeeeee $textToken');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? getTOken = prefs.getString('auth-token');
      Map<String, String> headersForAuth = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $getTOken',
      };
      var url = Appurl.baseURL + 'api/profile';

      http.Response response =
          await http.get(Uri.parse(url), headers: headersForAuth);

      if (response.statusCode == 200) {
        isLoading.value = true;
        var data = UserProfileModel.fromJson(jsonDecode(response.body));
        userProfileModel.value = data;
      } else {
        print('User not found');
      }
      isLoading.value = false;
      update();
    } catch (e) {
      print(e.toString());
    }
    update();
  }
}
