import 'package:flutter/material.dart';
import 'package:sv_craft/constant/color.dart';

class BottomButton extends StatelessWidget {
  VoidCallback onTap;
  String buttonText;
  IconData buttonIcon;
  double top;
  double left;
  double right;
  double bottom;
  BottomButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.buttonIcon,
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: Container(
          alignment: Alignment.center,
          width: size.width * .90,
          height: size.height / 15,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Appcolor.circleColor,
                Color.fromARGB(255, 207, 207, 207),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: size.width * 0.25),
                Text(
                  buttonText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.black),
                ),
                SizedBox(width: 30),
                Icon(
                  buttonIcon,
                  color: Colors.black,
                  size: 36.0,
                  //weight: IconWeight.bold
                ),
              ],
            ),
          ),
        ));
  }
}
