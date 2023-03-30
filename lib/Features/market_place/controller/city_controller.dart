import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/market_city_model.dart';

import '../../../constant/api_link.dart';
import '../../../services/services.dart';

class MarketCityController extends GetxController {
  Future<List<MarketCitiesData>?> getmarketCity(String textToken) async {
    try {
      const url = Appurl.baseURL+"api/get-cities";

      http.Response response = await http.get(Uri.parse(url), headers:ServicesClass.headersForAuth);

      if (response.statusCode == 200) {
        final marketCategory = marketCitiesFromJson(response.body);
        return marketCategory.data;
      } else {
        print('City not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
