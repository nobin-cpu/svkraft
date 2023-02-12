import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sv_craft/Features/seller_profile/models/seller_profile_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';
import 'package:http/http.dart' as http;

class MyWidgett extends StatelessWidget {
  MyWidgett({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var sellerProfile;
    return Container(
      height: 100,
      width: 200,
      color: Colors.amberAccent,
      child:Center(child: Text(
        "phone no.",
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),)
    );
  }
}

class ShowSellerProfileController extends GetxController {
  Future<SellerProfile?> getSellerProfileProduct(
    String textToken,
    String sellerId,
  ) async {
    try {
      var url = Appurl.baseURL + "api/product/user/$sellerId";

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      // print(response.body);
      if (response.statusCode == 200) {
        final sellerProfile = sellerProfileFromJson(response.body);

        return sellerProfile;
      } else {
        print('Seller not found');
      }
    } catch (e) {
      getSellerProfileProduct(textToken, sellerId);
    }
    return null;
  }
}
