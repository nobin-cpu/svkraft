
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/subscription_model.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/services/services.dart';

class MemberShipController extends GetxController {
  late SubscriptionModel subscriptionModel;
  RxBool isLoading =false .obs;

  void getSubscriptionsModel() async {
    isLoading.value = true;
  
    try {
      var url = Appurl.baseURL + "api/packages";

      var response =
          await http.get(Uri.parse(url), headers: ServicesClass.headersForAuth);

      print(response.body);
      if (response.statusCode == 200) {
        var subscriptions = subscriptionModelFromJson(response.body);
        subscriptionModel = subscriptions;
      
      } else {
        print('subscriptions not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
      
    }
      isLoading.value = false;
    update();
  }
}
