import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ToothWidget extends StatelessWidget {
  final bool? isSelected;
  final bool? hasRecord;
  final String toothId;
  final bool isUpper;
  final isCenterTooth;
  final VoidCallback? onTap;

  const ToothWidget(
      {Key? key,
      this.isSelected,
      this.hasRecord,
      required this.toothId,
      required this.isUpper,
      this.onTap,
      this.isCenterTooth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTap!(),
      child: Column(
        children: [
          Visibility(
            visible: isUpper,
            child: Text(toothId),
          ),
          Container(
            height: 38,
            width: 38,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: isSelected != null && isSelected == true
                  ? Colors.grey.shade500
                  : Colors.white,
              border: isCenterTooth
                  ? Border.all(color: Colors.blueAccent, width: 2)
                  : Border.all(color: Colors.black, width: 0.8),
            ),
            child: SvgPicture.asset(
              'assets/icons/tooth.svg',
              color: hasRecord != null && hasRecord == true
                  ? Palettes.kcBlueMain1
                  : Colors.black,
            ),
          ),
          Visibility(
            visible: !isUpper,
            child: Text(toothId),
          ),
        ],
      ),
    );
  }
}
