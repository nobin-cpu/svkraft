import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sv_craft/constant/constant.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: AppImage.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                child: Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
