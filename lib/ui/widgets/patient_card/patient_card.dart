import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PatientCard extends StatelessWidget {
  final String image;
  final String name;
  final String phone;
  final String address;
  final String? age;
  final String? birthDate;
  PatientCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.phone,
      required this.address,
      this.age,
      this.birthDate})
      : super(key: key);

  final urlLauncherService = locator<URLLauncherService>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                border: Border.all(
                  color: Palettes.kcNeutral3,
                  width: 1,
                )),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(105),
              child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  progressIndicatorBuilder: (context, url, progress) =>
                      CircularProgressIndicator(
                        value: progress.progress,
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white,
                        ),
                      )),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.tsHeading4(color: Palettes.kcNeutral1),
                ),
                Row(
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                    ),
                    Text(
                      '$age',
                      style: TextStyles.tsHeading5(color: Palettes.kcNeutral1),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Call.svg',
                              height: 18,
                              width: 18,
                              color: Palettes.kcBlueDark,
                            ),
                            SizedBox(width: 5),
                            Text(
                              phone,
                              style: TextStyles.tsBody2(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Location.svg',
                              height: 20,
                              width: 20,
                              color: Palettes.kcBlueDark,
                            ),
                            SizedBox(width: 5),
                            Text(
                              address,
                              style: TextStyles.tsBody2(
                                color: Colors.grey.shade700,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/Calendar.svg',
                              height: 18,
                              width: 18,
                              color: Palettes.kcBlueDark,
                            ),
                            SizedBox(width: 5),
                            Text(
                              birthDate ?? '',
                              style: TextStyles.tsBody2(
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            urlLauncherService.callPhoneNumber(phone: phone);
                          },
                          icon: Icon(Icons.call_rounded),
                          color: Palettes.kcBlueMain1,
                          padding: EdgeInsets.zero,
                        ),
                        IconButton(
                          onPressed: () {
                            urlLauncherService.sendTextMessage(phone: phone);
                          },
                          icon: Icon(Icons.message),
                          color: Palettes.kcBlueMain1,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
