import 'package:file/memory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/home_screen.dart';

class success extends StatelessWidget {
  const success({super.key});

  @override
  Widget build(BuildContext context) {
    return
        //  Image.asset(
        //   "images/w.jpeg",
        //   fit: BoxFit.cover,
        // );
        WillPopScope(
            onWillPop: () async {
              Get.to(() => HomeScreen());
              return true;
            },
            child: //  Image.asset(
                Image.asset(
              "images/w.jpeg",
              fit: BoxFit.cover,
            ));
  }
}
