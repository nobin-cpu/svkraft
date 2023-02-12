// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:sv_craft/Features/market_place/controller/category_controller.dart';

// import '../../../constant/api_link.dart';

// class Final2cheakout extends GetxController {
//   RxString timeAndDate = "".obs;

//   finalCheckout2({required String textToken, required String address}) async {
//     http.Response response = await http
//         .post(Uri.parse(Appurl.baseURL + 'api/order/create-handcash'), body: {
//       "address": address,
//       "pickup_time": timeAndDate.value,
//     }, headers: {
//       // 'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $textToken',
//     });
//     print("response::::${response.body}");
//     if (response.statusCode == 200) {
//       return response.statusCode;
//     } else {
//       errorSnackBar(title: "faild upload".tr, message: "Unavailable".tr);
//     }
//   }

//   void getTimeAndDate(value) {
//     timeAndDate.value = value;
//   }
// }
