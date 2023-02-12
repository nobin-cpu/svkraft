import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/Features/special_day/model/search_model.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';
import 'package:sv_craft/constant/api_link.dart';

class SepecialSearchController extends GetxController {
  Future<List<SecialSearch>?> getSpecialSearchProducts(
      String textToken, name) async {
    try {
      var uri = Appurl.baseURL + "api/special-day/search/$name";
      http.Response response =
          await http.get(Uri.parse(uri), headers: ServicesClass.headersForAuth);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final specialSearch = specialAllProductFromJson(response.body);
        print("MESSAGE " + specialSearch.data.length.toString());
        // return specialSearch.data;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// class SepecialSearchController {
//   late Map<String, dynamic> specialSearch;

//   getSpecialSearchProducts(String textToken, name) async {
//     var response = await http.get(
//         Uri.parse("http://gigsoft.net/api/special-day/search/$name"),
//         headers: ServicesClass.headersForAuth);

//     specialSearch = Map<String, dynamic>.from(jsonDecode(response.body));

//     print(' DATA ======================== $specialSearch');
//   }

//   @override
//   void initState() {
//     getSpecialSearchProducts("textToken", "name");
//     initState();
//   }
// }
