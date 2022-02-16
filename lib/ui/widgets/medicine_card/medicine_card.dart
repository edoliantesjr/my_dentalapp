import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedicineCard extends StatelessWidget {
  final String id;
  final String name;
  final String? price;
  final String? image;
  final String? brandName;
  const MedicineCard(
      {Key? key,
      required this.id,
      required this.name,
      this.brandName,
      this.price,
      this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          //  todo: design code for medicine card
          SizedBox(height: 5),
          SizedBox(
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: showMedImage(image),
            ),
          ),
          SizedBox(height: 5),
          FittedBox(
            child: Text(
              brandName ?? 'No Brand',
              style: TextStyles.tsHeading4(),
            ),
          ),
          FittedBox(
            child: Text(
              name,
              style: TextStyles.tsBody2(color: Colors.grey.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget showMedImage(String? image) {
    if (image == null) {
      // return Image.asset(
      //   'assets/images/dev1.jpg',
      //   fit: BoxFit.contain,
      // );
      return SvgPicture.asset(
        'assets/icons/Pills.svg',
        color: Colors.purple,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      );
    }
  }
}
