import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constant/api_link.dart';

class AddressController extends GetxController {
  saveAddress(
      String name, phone, house, colony, city, area, address, textToken) async {
    try {
      print(textToken);
      http.Response response = await http
          .post(Uri.parse(Appurl.baseURL + 'api/shipping-address'), body: {
        'name': name,
        'phone': phone,
        'house': house,
        'colony': colony,
        'city': city,
        'area': area,
        'address': address,
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("response Data::::::$data");

        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
