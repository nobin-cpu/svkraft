import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/services/services.dart';

import '../../../constant/api_link.dart';
import '../controllar/final_checkout_con.dart';
import '../model/time_and_date.dart';

class PickDateTime extends StatefulWidget {
  const PickDateTime({super.key});

  @override
  State<PickDateTime> createState() => _PickDateTimeState();
}

class _PickDateTimeState extends State<PickDateTime> {
  DateAndTimeModel dateAndTimeModel = DateAndTimeModel();
  bool isLoading = false;
  FinalCheckoutController final_checkout_con =
      Get.put(FinalCheckoutController());
  int dateSelectedIndex = 100;
  int timeSelectedIndex = 100;
  var dateSelectedValue = "";
  var timeSelectedValue = "";

  @override
  void initState() {
    super.initState();
    getTimeAnddate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick date and time".tr),
      ),
      body: Container(
          child: isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .12,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: dateAndTimeModel.data!.dates!.length,
                          physics: const BouncingScrollPhysics(),
                          primary: false,
                          itemBuilder: (context, calanderIndex) {
                            var dates =
                                dateAndTimeModel.data!.dates![calanderIndex];
                            return InkWell(
                              onTap: () {
                                dateSelectedIndex = calanderIndex;
                                dateSelectedValue = dates.value.toString();
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: dateSelectedIndex == calanderIndex
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 0.8)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(dates.nameOfDay.toString()),
                                      Text(
                                        dates.date.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: dateAndTimeModel.data!.times!.length,
                        semanticChildCount: 1,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (9 / 2),
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          var times = dateAndTimeModel.data!.times![index];
                          return InkWell(
                            onTap: () {
                              timeSelectedIndex = index;
                              timeSelectedValue = times.value.toString();
                              setState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: timeSelectedIndex == index
                                        ? Colors.blue
                                        : Colors.white,
                                    border: Border.all(
                                        width: 1, color: Colors.grey)),
                                child:
                                    Center(child: Text(times.time.toString()))),
                          );
                        },
                      ),
                    ),
                  ]),
                )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Container(
          height: 50,
          child: ElevatedButton(
            child: Text("Done".tr),
            onPressed: () {
              final_checkout_con
                  .getTimeAndDate("${dateSelectedValue},${timeSelectedValue}");
              // if (dateSelectedValue != null) {
              //   final_checkout_con.getTimeAndDate(
              //       "${dateSelectedValue},${timeSelectedValue}");
              // } else {
              //   Get.bottomSheet(Text("empty"));
              //   print(timeSelectedIndex.toString());
              // }
              Get.back();
            },
          ),
        ),
      ),
    );
  }

  void getTimeAnddate() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await http.get(
        Uri.parse(Appurl.baseURL + 'api/time-schedule'),
        headers: ServicesClass.headersForAuth);

    if (response.statusCode == 200) {
      var data = DateAndTimeModel.fromJson(jsonDecode(response.body));
      dateAndTimeModel = data;
      setState(() {
        isLoading = false;
      });
    } else {
      errorSnackBar(title: "Faild", message: response.body.toString());
    }
  }
}
