import 'package:http/http.dart' as http;
import 'package:sv_craft/app/constant/api_constant.dart';

class NetworkCalling {
  static final client = http.Client();

// TODO: For all kind of get web service
  static Future<dynamic> get(String endpoint, String? token) async {
    var response = await client.get(Uri.parse(ApiConstant.base_url+endpoint),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response.body;
  }
}
