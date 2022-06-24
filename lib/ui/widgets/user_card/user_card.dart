import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? onTap;
  final UserModel user;
  const UserCard({Key? key, this.onTap, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap != null ? onTap!() : null,
        child: SizedBox(
          height: 130,
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 130,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: user.image,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.fullName,
                                style: TextStyles.tsHeading4(),
                              ),
                            ),
                            const SizedBox(width: 4),
                            user.active_status == 'active'
                                ? SizedBox(
                                    width: 53.sp,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(
                                          Icons.circle,
                                          size: 13,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 1),
                                        Text('Active'),
                                      ],
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 13,
                                        color: Colors.grey.shade800,
                                      ),
                                      const SizedBox(width: 1),
                                      const Text('On Leave'),
                                    ],
                                  ),
                            const SizedBox(width: 4),
                          ],
                        ),
                        Text(
                          user.position,
                          style: TextStyle(
                              fontSize: kfsBody3.sp,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
