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
              color: checkHistory(isSelected, hasRecord),
              border: isCenterTooth
                  ? Border.all(color: Colors.blueAccent, width: 2)
                  : Border.all(color: Colors.black, width: 0.8),
            ),
            child: SvgPicture.asset(
              'assets/icons/tooth.svg',
              color: hasRecord != null && hasRecord == true
                  ? Colors.white
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

  Color checkHistory(bool? isSelected, bool? hasRecord) {
    if (isSelected != null && isSelected) {
      return Colors.grey.shade500;
    } else if (hasRecord != null && hasRecord) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }
}
