import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/special_day/controllar/special_post_controller.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/shimmer_effects.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final SpecialPostController specialPostController =
      Get.put(SpecialPostController());
  @override
  void initState() {
    super.initState();
    specialPostController.getSpecialRemainder();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            floatingActionButton: TextButton.icon(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.yellow.shade700)),
              icon: Icon(Icons.add),
              label: Text("Click here to create new reminder".tr),
              onPressed: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    context: context,
                    builder: (builder) {
                      return Obx(() => Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Set Your Special Day".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: specialPostController
                                      .textEditingController.value,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Title *'.tr,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("count".tr +
                                    " : ${specialPostController.compareTwoDateTime.value} " +
                                    "Days Left".tr),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("Time".tr +
                                //         ": ${specialPostController.formattedTime.value}"),
                                //     ElevatedButton.icon(
                                //         icon: const Icon(
                                //           Icons.watch_later_outlined,
                                //           color: Colors.white,
                                //         ),
                                //         onPressed: () {
                                //           specialPostController
                                //               .getTimeSelect(context);
                                //         },
                                //         label: Text("Pick Time".tr)),
                                //   ],
                                // ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("date".tr +
                                        " : ${specialPostController.convertedDate.value}"),
                                    ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.date_range_outlined,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          specialPostController
                                              .getDateSelect(context);
                                        },
                                        label: Text("Pick Date".tr)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                specialPostController.imagepath.value ==
                                        "https://svkraft.shop/reminders/default.jpg"
                                    ? const SizedBox()
                                    : Text(
                                        "You are selected image".tr,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.image_rounded,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      specialPostController
                                          .getImageFromMGallery();
                                    },
                                    label: Text("Upload cover image".tr)),
                                const SizedBox(height: 10),
                                specialPostController.textEditingController
                                        .value.text.isNotEmpty
                                    ? ElevatedButton.icon(
                                        icon: const Icon(
                                          Icons.done_outline_sharp,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          specialPostController
                                              .postSpecialCard();
                                        },
                                        label: Text("Submit".tr))
                                    : ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey)),
                                        icon: const Icon(
                                          Icons.done_outline_sharp,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                        label: Text("Title required".tr))
                              ],
                            ),
                          )));
                    });
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Reminder'.tr),
              actions: const [
                Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
                SizedBox(width: 10)
              ],
            ),
            body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(
                  () => specialPostController.isLoading.value == true
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: specialPostController
                                  .specialRemainderModel.value.data!.length,
                              itemBuilder: (context, index) {
                                var specialItems = specialPostController
                                    .specialRemainderModel.value.data![index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(8),
                                    padding: const EdgeInsets.all(6),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      child: Container(
                                        height: size.height * .2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    Appurl.baseURL +
                                                        specialItems.image
                                                            .toString()),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.5),
                                                    BlendMode.darken))),
                                        // color: Colors.amber,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Text(
                                                  specialItems.title.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Positioned(
                                              right: 10,
                                              top: 10,
                                              child: Text(
                                                  specialItems.time.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                ))));
  }
}
