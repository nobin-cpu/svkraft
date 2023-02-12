import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserProfileController extends GetxController {
  var imagePath = "null".obs;
  final _picker = ImagePicker();
  var dropdownValue = "Male".obs;

  var dateController = TextEditingController().obs;

  Future<void> getImageFromMGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      print(imagePath);
      update();
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
    Get.back();
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      print(imagePath);
      update();
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
    Get.back();
  }

  void getDatePicker(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);

      dateController.value.text = formattedDate;
      update();
    } else {}
    update();
  }

  void getGender(String value) {
    dropdownValue.value = value;
    update();
  }
}
