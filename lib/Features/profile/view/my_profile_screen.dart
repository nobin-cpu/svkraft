import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sv_craft/Features/profile/controller/user_profile_controller.dart';
import 'package:sv_craft/Features/seller_profile/view/conto.dart';
import 'package:sv_craft/constant/api_link.dart';

import '../controller/get_profile_con.dart';
import '../models/user_profile_model.dart';
import 'package:http/http.dart' as http;

class MyProfileScreen extends StatefulWidget {
  final UserProfileModel userProfileModel;

  MyProfileScreen({super.key, required this.userProfileModel});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController mailController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  GetProfileController getProfileController = Get.put(GetProfileController());

  final userProfileController = Get.put(UserProfileController());
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  DateTime pickedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    var users = widget.userProfileModel.data;
    nameController = TextEditingController(text: users!.name ?? "");
    mailController = TextEditingController(text: users.email ?? "");
    phoneController = TextEditingController(text: users.phone ?? "");
    addressController = TextEditingController(text: users.location ?? "");
    userProfileController.dateController.value.text =
        users.dateOfBirth ?? "Pick date".toString();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var users = widget.userProfileModel.data!;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile".tr),
        actions: [
          ElevatedButton(
              onPressed: () {
                updateTheUserProfile();
              },
              child: Text(
                "Save".tr,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ))
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: isLoading
            ? SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // ignore: unrelated_type_equality_checks
                          Obx(() => userProfileController.imagePath == null
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                      Appurl.baseURL + users.image),
                                )
                              : CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(File(
                                      userProfileController.imagePath.value)),
                                )),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    Get.bottomSheet(
                                      backgroundColor: Colors.transparent,
                                      Container(
                                          height: 150,
                                          color: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    userProfileController
                                                        .getImageFromCamera();
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.camera),
                                                      SizedBox(width: 10),
                                                      Text("Image from Camera"
                                                          .tr)
                                                    ],
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    PermissionStatus
                                                        _galarystatus =
                                                        await Permission.camera
                                                            .request();
                                                    if (_galarystatus ==
                                                        PermissionStatus
                                                            .granted) {
                                                      userProfileController
                                                          .getImageFromMGallery();
                                                    }
                                                    if (_galarystatus ==
                                                        PermissionStatus
                                                            .denied) {
                                                      Get.back();
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.image),
                                                      SizedBox(width: 10),
                                                      Text("Image from Gallery"
                                                          .tr)
                                                    ],
                                                  ))
                                            ],
                                          )),
                                      isDismissible: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      enableDrag: false,
                                    );
                                  },
                                  child: Text("Change your photo".tr)),
                              SizedBox(height: 4),
                              Text(
                                  "Only JPG, JPEG, PNG \nformat file supported."
                                      .tr),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 125, 145))),
                            hintText: "Enter your name".tr,
                            labelText: "Name *".tr,
                          ),
                          onSaved: (String? value) {},
                        ),
                      ),
                      // SizedBox(height: 6),
                      // SizedBox(
                      //   child: TextFormField(
                      //     controller: mailController,
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.grey)),
                      //       focusedBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.black),
                      //       ),
                      //       errorBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 66, 125, 145))),
                      //       hintText: "Enter your mail".tr,
                      //       labelText: "Mail".tr,
                      //     ),
                      //     onSaved: (String? value) {},
                      //   ),
                      // ),
                      SizedBox(height: 6),
                      SizedBox(
                        child: TextFormField(
                          controller: phoneController,
                          readOnly: users.phone == "" || users.phone == null
                              ? false
                              : true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      users.phone == "" || users.phone == null
                                          ? Colors.black
                                          : Colors.grey),
                            ),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 66, 125, 145))),
                            hintText: users.phone == "" || users.phone == null
                                ? "Enter your phone "
                                : users.phone,
                            labelText: "Phone Number".tr,
                          ),
                          onSaved: (String? value) {},
                        ),
                      ),
                      SizedBox(height: 6),
                      Obx(() => TextFormField(
                            onTap: () {
                              userProfileController.getDatePicker(context);
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                hintText: userProfileController
                                    .dateController.value.text),
                          )),
                      SizedBox(height: 10),
                      TextField(
                        controller: addressController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 66, 125, 145))),
                          hintText: "Address".tr,
                          labelText: "Address".tr,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Text("Select Gender".tr),
                          SizedBox(width: 10),
                          Obx(() => DropdownButton<String>(
                                value:
                                    userProfileController.dropdownValue.value,
                                items: <String>[
                                  'Male'.tr,
                                  'Female'.tr,
                                  'Other'.tr
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  userProfileController.getGender(value!);
                                },
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  SizedBox textFeildController({
    required TextEditingController name,
    required String hintText,
    required String lebelName,
  }) {
    return SizedBox(
      child: TextFormField(
        controller: name,
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 66, 125, 145))),
          hintText: hintText,
          labelText: lebelName,
        ),
        onSaved: (String? value) {},
      ),
    );
  }

  void updateTheUserProfile() async {
    var object = {
      'name': nameController.text,
      // 'Email': mailController.text,
      'Phone': phoneController.text,
      'location': addressController.text,
      'date_of_birth': userProfileController.dateController.value.text,
      'gender': userProfileController.dropdownValue.value,
    };
    setState(() {
      isLoading = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse(Appurl.baseURL + 'api/profile'));
    request.fields.addAll(object);
    userProfileController.imagePath.value == "null"
        ? print("imageNull")
        : request.files.add(await http.MultipartFile.fromPath(
            'image', userProfileController.imagePath.value));
    request.headers.addAll(ServicesClass.headersForAuth);

    http.StreamedResponse response = await request.send();
    print("Response::::${response.statusCode}");
    print("Object::::$object");

    if (response.statusCode == 200) {
      // print("Response::::::" + await response.stream.bytesToString());
      Get.snackbar(
          colorText: Colors.white,
          backgroundColor: Colors.green,
          "Profile Update",
          "Profile Update Successfull");

      getProfileController.getUserProfile(token);
      // addUserinIFrenase();

      Navigator.pop(context);
    } else {
      print("errorr::::" + response.reasonPhrase.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  // late CollectionReference _collectionReference;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // void addUserinIFrenase() async {
  //   print("CheckHomeFirebase:::");
  //   firebaseFirestore
  //       .collection('users')
  //       .doc(getProfileController.userProfileModel.value.data!.id.toString())
  //       .set({
  //     "name": getProfileController.userProfileModel.value.data!.name.toString(),
  //     "userid": getProfileController.userProfileModel.value.data!.id.toString(),
  //     "photoUrl":
  //         getProfileController.userProfileModel.value.data!.image.toString(),
  //   }).whenComplete(() => {print("Firenase....COmplete::::")});
  // }

}

//change
