import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHomePageAppBar extends StatelessWidget with PreferredSizeWidget {
  final String image;
  final String position;
  final String name;
  final VoidCallback? onLogOutTap;
  final VoidCallback onTapUser;
  final VoidCallback? onNotificationTap;
  const CustomHomePageAppBar(
      {Key? key,
      required this.image,
      required this.position,
      required this.name,
      this.onNotificationTap,
      this.onLogOutTap,
      required this.onTapUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height + 20,
        color: Palettes.kcBlueMain1,
        child: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(1, 2),
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () => onTapUser(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    CircularProgressIndicator(
                              value: progress.progress,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Container(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Welcome!',
                      style: TextStyles.tsHeading5(color: Colors.white),
                    ),
                    Visibility(
                      visible: position.isNotEmpty,
                      child: Text(
                        position != 'Staff' ? 'Doc. $name' : '$name',
                        style: TextStyles.tsBody2(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 40),
              IconButton(
                onPressed: () => onNotificationTap!(),
                padding: EdgeInsets.zero,
                splashColor: Colors.transparent,
                alignment: Alignment.centerRight,
                icon: SvgPicture.asset(
                  'assets/icons/Notification - Noti.svg',
                ),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () => onLogOutTap != null ? onLogOutTap!() : null,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'assets/icons/Logout.svg',
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(0, 75);
}
