import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.text,
    required this.textColor,
    required this.imageLink,
    required VoidCallback this.onTap,
  }) : super(key: key);

  final String text;

  final Color textColor;
  final String imageLink;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(143, 211, 133, 159), //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 0, // blur radius
              offset: Offset(0, 0), // changes position of shadow
            )
          ],
        ),
        width: size.width * .3,
        height: size.width * .38,
        child: Container(
          // margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(imageLink),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.darken)),
          ),
          width: size.width * .5,
          height: size.width * .38,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .07,
              ),
              Container(
                // margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 143, 51, 123),
                ),
                // width: size.width * .5,
                height: size.width * .08,
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// child: Container(
//           image: DecorationImage(
//               image: NetworkImage(imageLink),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.6), BlendMode.darken)),
//         ),

//  Text(
//           text,
//           style: TextStyle(color: textColor, fontSize: 18),
//           textAlign: TextAlign.center,
//         ),