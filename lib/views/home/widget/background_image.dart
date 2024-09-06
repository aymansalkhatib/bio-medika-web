import 'package:bio_medika_web/core/constant/app_assets_png.dart';
import 'package:flutter/material.dart';

class BackgroundImageHome extends StatelessWidget {
  const BackgroundImageHome({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(
      alignment: Alignment.topCenter,
      width: size.width,
      height: size.height,
      AppAssetsPng.background,
      fit: BoxFit.cover,
    );
  }
}
