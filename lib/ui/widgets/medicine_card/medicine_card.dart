import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
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
      color: Colors.white,
      padding: const EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: showMedImage(image),
          ),
          const Divider(height: 1),
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: FittedBox(
              child: Text(
                brandName ?? 'No Brand',
                style: TextStyles.tsHeading4(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                name,
                style: TextStyles.tsBody2(color: Colors.grey.shade700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Text(
                price ?? 'Not Set',
                style: TextStyles.tsBody2(color: Colors.deepOrange),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showMedImage(String? image) {
    if (image == null || image == '') {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 50,
          width: 50,
          child: SvgPicture.asset(
            'assets/icons/Pills.svg',
            color: Colors.purple,
          ),
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        progressIndicatorBuilder: (context, url, progress) =>
            LinearProgressIndicator(
          color: Colors.grey.shade100,
          value: progress.progress,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      );
    }
  }
}
