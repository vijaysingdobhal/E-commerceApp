import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Repository/Widget/UIhelper.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;

  const CategoryCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.2;

    return Column(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: UiHelper.CostomImage(img: image),
        ),
        const SizedBox(height: 6),
        UiHelper.customText(
          text: title,
          color: Colors.black,
          fontSize: 12,
          fontFamily: "Poppins", fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
