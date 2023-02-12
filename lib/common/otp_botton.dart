import 'package:flutter/material.dart';
import 'package:sv_craft/constant/color.dart';

class OTPbutton extends StatelessWidget {
  VoidCallback onTap;
  String buttonText;
  IconData buttonIcon;

  OTPbutton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.buttonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: size.width * .5,
        height: size.height * .05,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Appcolor.circleColor,
              Color.fromARGB(255, 253, 251, 250),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(width: size.width * 0.25),
              Text(
                buttonText,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black),
              ),
              // SizedBox(width: 30),
              // Icon(
              //   buttonIcon,
              //   color: Colors.black,
              //   size: 36.0,
              //   //weight: IconWeight.bold
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
