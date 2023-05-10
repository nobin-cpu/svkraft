import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/home/home_screen.dart';

import 'package:sv_craft/constant/api_link.dart';

class Reportuser extends StatefulWidget {
  final String id;
  Reportuser({super.key, required this.id});

  @override
  State<Reportuser> createState() => _ReportuserState();
}

class _ReportuserState extends State<Reportuser> {
  Future reportuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'authorization': "Bearer $token"
    };
    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Appurl.reportuser),
    );
    request.fields.addAll({
      'userId': widget.id.toString(),
      'message': officer.toString(),
    });

    // if (_image != null) {
    //   request.files
    //       .add(await http.MultipartFile.fromPath('attached_file', _image.path));
    // }

    request.headers.addAll(requestHeaders);

    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          // saveprefs(data["data"]["bearer_token"]);
          // chat.clear();

          setState(() {});
          Get.to(HomeScreen());
        } else {
          print("Fail! ");
          print(response.body.toString());
          // Fluttertoast.showToast(
          //     msg: "Error Occured",
          //     toastLength: Toast.LENGTH_LONG,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          return response.body;
        }
      });
    });
  }

  saveprefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('auth-token', token);
  }

  String officer = 'Violent content';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Report user".tr),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Select a reason below to report".tr),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .07,
              width: double.infinity,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(10),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'Select a reason',
                  hintText: 'Choose Officer',
                ),
                dropdownColor: Color.fromARGB(255, 255, 255, 255),
                value: officer,
                onChanged: (String? newValue) {
                  setState(() {
                    officer = newValue!;
                  });
                },
                items: <String>[
                  'Violent content',
                  'Abbusive language',
                  'potential violence',
                  'Others'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * .35, top: size.height * .05),
            child: ElevatedButton(
                onPressed: () {
                  reportuser();
                  print(officer);
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Submit".tr),
                )),
          )
        ],
      )),
    );
  }
}
