import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  List images = [];
  RxString imagesFiles1 = "".obs;
  RxString imagesFiles2 = "".obs;
  RxString imagesFiles3 = "".obs;

  RxString imagesFiles4 = "".obs;
  RxString imagesFiles5 = "".obs;
  RxString imagesFiles6 = "".obs;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImageFromMGallery1() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles1.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

  Future<void> getImageFromMGallery2() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles2.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

  Future<void> getImageFromMGallery3() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles3.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

  Future<void> getImageFromMGallery4() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles4.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

  Future<void> getImageFromMGallery5() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles5.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

  Future<void> getImageFromMGallery6() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagesFiles6.value = pickedFile.path;
      images.add(pickedFile.path);
    } else {
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.red,
          "Error",
          "Image picked faild.");
    }
  }

//  void

}
