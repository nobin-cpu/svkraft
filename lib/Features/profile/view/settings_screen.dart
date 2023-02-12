import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/constant/color.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List locale = [
    {'name': 'English', 'locale': Locale("eng")},
    {'name': 'Svenska', 'locale': Locale("swe")},
    {'name': 'عربى', 'locale': Locale("arabic")}
  ];
  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (Builder) {
          return AlertDialog(
            title: Text("choose a language".tr),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: locale.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        updatelanguage(locale[index]["locale"]);
                      },
                      child: Text(locale[index]["name"]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
              ),
            ),
          );
        });
  }

  String selectedValue = "Select Language";
  List<String> list = ["Name", "Title"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      builddialog(context);
                    },
                    child: Text("Change Language".tr)))
          ],
        ),
      ),
    );
  }
}
