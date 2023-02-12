import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/seller_profile/models/seller_profile_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';

class OnlyProfile extends GetxController {
  Future<SellerProfile?> getAllProduct(
    String textToken,
    dynamic sellerId,
  ) async {
    try {
      var url = Appurl.baseURL + "api/product/user/$sellerId";

      http.Response response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth,);

      // print(response.body);
      if (response.statusCode == 200) {
        final sellerProfile = sellerProfileFromJson(response.body);

        return sellerProfile;
      } else {
        print('Seller not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
    return null;
  }

//   Future<SellerProfile> fetchAlbum(String sellerId, String textToken) async {
//     var url = Appurl.baseURL + "api/product/user/$sellerId";

//     http.Response response =
//         await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       return SellerProfile.fromJson(jsonDecode(response.body));
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load album');
//     }
//   }
// }
}
