import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final VoidCallback? onTap;
  final UserModel user;
  const UserCard({Key? key, this.onTap, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap != null ? onTap!() : null,
        child: SizedBox(
          height: 110,
          child: Card(
            elevation: 2,
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullName,
                          style: TextStyles.tsHeading4(),
                        ),
                        SizedBox(height: 5),
                        Text(
                          user.position,
                          style: TextStyles.tsBody3(),
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
