import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sv_craft/Features/home/home_caroucel.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class ShimmerEffect {
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
  static gridviewShimerLoader() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 5,
          itemBuilder: (context, index) {
            return VideoShimmer(
              colors: ShimmerEffect.shimmerGradient.colors,
            );
          }),
    );
  }

  static horizontalScrollItems() {
    return Container(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return PlayStoreShimmer(
              colors: ShimmerEffect.shimmerGradient.colors,
            );
          }),
    );
  }

  static listSimmerEffect() {
    return ListView(
      children: [
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
        ListTileShimmer(
          colors: ShimmerEffect.shimmerGradient.colors,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  static profileShimmerEffect() {
    return ListView(
      children: const [
        ProfilePageShimmer(),
        VideoShimmer(),
        VideoShimmer(),
        VideoShimmer(),
      ],
    );
  }

  static carous() {
    return YoutubeShimmer();
  }
}
