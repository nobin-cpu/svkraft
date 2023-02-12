import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sv_craft/constant/color.dart';
import 'widgets/text_input_field.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController? _nameController = TextEditingController();
  final TextEditingController? _genderController = TextEditingController();
  final TextEditingController? _birthdayController = TextEditingController();
  final TextEditingController? _addressController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController!.dispose();
    _genderController!.dispose();
    _birthdayController!.dispose();
    _addressController!.dispose();
  }

  @override
  void initState() {
    // _birthdayController.text = ""; //set the initial value of text field
    super.initState();
  }

  // late Rx<File?> _pickedImage;
  // File? get profilePhoto => _pickedImage.value;
  // void pickImage() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     Get.snackbar('Profile Picture',
  //         'You have successfully selected your profile picture!');
  //   }
  //   _pickedImage = Rx<File?>(File(pickedImage!.path));
  // }
  // late File imageFile;
  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
              ),
              const Text(
                'Edit Your Profile',
                style: TextStyle(
                  fontSize: 35,
                  color: Appcolor.primaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                    ),
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {}, //=> _getFromGallery(),
                      icon: const Icon(Icons.add_a_photo,
                          color: Appcolor.subTextColor, size: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _nameController!,
                  labelText: 'Username',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  //margin: ,
                  height: 80,
                  child: Center(
                      child: TextField(
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_month),
                      labelText: "Birth Date",
                      // prefixIcon: Icon(icon),
                      labelStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Appcolor.primaryColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Appcolor.primaryColor,
                          )),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          _birthdayController!.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ))),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _addressController!,
                  labelText: 'Address',
                  icon: Icons.location_city_outlined,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Appcolor.circleColor,
                      Color.fromARGB(255, 128, 118, 175),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const InkWell(
                  // onTap: () => authController.registerUser(
                  //   _usernameController.text,
                  //   _emailController.text,
                  //   _passwordController.text,
                  //   authController.profilePhoto,
                  // ),
                  child: Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Appcolor.uperTextColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 255,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
