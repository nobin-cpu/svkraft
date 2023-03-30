import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/constant/color.dart';

import '../../../constant/api_link.dart';
import '../../../main.dart';
import '../../cart/model/show_cart_model.dart';
import '../model/special_remainder_model.dart';

class SpecialPostController extends GetxController {
  var specialRemainderModel = SpecialRemainderModel().obs;
  RxBool isLoading = false.obs;
  var convertedDate = "".obs;
  RxString formattedTime = "".obs;
  RxString compareTwoDateTime = ''.obs;
  RxString imagepath = "https://svkraft.shop/reminders/default.jpg".obs;
  var textEditingController = TextEditingController().obs;

  final ImagePicker _picker = ImagePicker();
  void getDateSelect(context) async {
    convertedDate.value = DateFormat.yMMMEd().format(DateTime.now()).toString();
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (pickedDate != null) {
      convertedDate.value =
          DateFormat('yyyy-MM-dd').format(pickedDate).toString();
      final birthday =
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      final date2 = DateTime.now();
      var days = date2.difference(birthday).inDays.toString();
      var getDays = int.parse(days) + -1;
      String stringdays = getDays.toString();

      compareTwoDateTime.value = stringdays.substring(1);
    } else {
      // Get.snackbar(
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //     "Pick Time and Date",
      //     "You need to pick time and date");
    }
    // getTimeSelect(context);
  }

  void getTimeSelect(context) {
    DatePicker.showTimePicker(context,
        showSecondsColumn: false,
        showTitleActions: true,
        onChanged: (date) {}, onConfirm: (date) {
      formattedTime.value = "${date.hour}:${date.minute}";
    }, currentTime: DateTime.now());
  }

  Future<void> getImageFromMGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagepath.value = pickedFile.path;
      print(imagepath);
      update();
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error".tr,
          "Image picked faild.".tr);
    }
  }

  void getSpecialRemainder() async {
    isLoading.value = true;
    var url = Appurl.baseURL + 'api/special-day/reminder/all';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    http.Response response =
        await http.get(Uri.parse(url), headers: headersForAuth);

    if (response.statusCode == 200) {
      final specialDays =
          SpecialRemainderModel.fromJson(jsonDecode(response.body));
      specialRemainderModel.value = specialDays;
      isLoading.value = false;
      print("specialDays:::$specialDays:::");
    } else {
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Special Day",
          response.body.toString());
    }
  }

  void postSpecialCard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getTOken = prefs.getString('auth-token');
    Map<String, String> headersForAuth = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $getTOken',
    };
    var headers = {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(Appurl.baseURL + 'api/special-day/reminder'));
    request.fields.addAll({
      'title': textEditingController.value.text,
      'datetime': convertedDate.value + " " + formattedTime.value
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', imagepath.value));
    request.headers.addAll(headersForAuth);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("suscces:::::" + await response.stream.bytesToString());
      getSpecialRemainder();
      Get.back();

      textEditingController.value.clear();
      imagepath.value = "https://svkraft.shop/reminders/default.jpg";

      // Get.snackbar(
      //         backgroundColor: Colors.green,
      //         colorText: Colors.white,
      //         "Special Day".tr,
      //         "Record created successfully".tr)

      // var context;
      // showDialog(context: context, builder: (BuildContext context) => AlertDialog(title: new Text('Message'),));
      Get.defaultDialog(
          title: "Special Day".tr,
          middleText: "Record created successfully".tr,
          backgroundColor: Appcolor.primaryColor,
          titleStyle: TextStyle(color: Colors.white),
          middleTextStyle: TextStyle(color: Colors.white),
          radius: 30,
          actions: [
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    Get.to(() => HomeScreen());
                  },
                  child: Text(
                    "OK".tr,
                    style: TextStyle(color: Colors.black),
                  )),
            )
          ]);

      getSpecialRemainder();
    } else {
      print("Errorr::::" + response.reasonPhrase.toString());
      Get.snackbar(
          backgroundColor: Colors.red,
          colorText: Colors.white,
          "Special Day",
          response.reasonPhrase.toString());
    }
  }
}
