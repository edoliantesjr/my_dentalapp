import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/select_patient/select_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class SelectPatientView extends StatelessWidget {
  const SelectPatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectPatientViewModel>.reactive(
      viewModelBuilder: () => SelectPatientViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text(
            'Select Patient',
            style: TextStyle(color: Colors.white, fontSize: 21),
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add Patient',
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, onPrimary: Palettes.kcNeutral1),
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: RefreshIndicator(
            color: Palettes.kcBlueMain1,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
            },
            child: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverStickyHeader(
                  overlapsContent: false,
                  header: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    color: Palettes.kcBlueMain1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          onChanged: (value) => model.searchPatient(value),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Palettes.kcBlueMain1,
                                width: 1.8,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                'assets/icons/Search.svg',
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  'assets/icons/Filter.svg',
                                ),
                              ),
                            ),
                            constraints: BoxConstraints(maxHeight: 43),
                            hintText: 'Search by Last Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  sliver: model.patientList.length != 0
                      ? SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            if (!model.patientList.isEmpty) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                  horizontalOffset: 200,
                                  child: FadeInAnimation(
                                    duration: Duration(milliseconds: 400),
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 8, bottom: 8),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade600,
                                            blurRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () {},
                                          child: SelectPatientCard(
                                            key: ObjectKey(
                                                model.patientList[index].id),
                                            name: model
                                                .patientList[index].fullName,
                                            image:
                                                model.patientList[index].image,
                                            phone: model
                                                .patientList[index].phoneNum,
                                            address: model
                                                .patientList[index].address,
                                            birthDate: model
                                                .patientList[index].birthDate,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }, childCount: model.patientList.length),
                        )
                      : SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(
                              child: Text('No Patients Found'),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectPatientCard extends StatelessWidget {
  final String image;
  final String name;
  final String phone;
  final String address;
  final String? age;
  final String? birthDate;
  const SelectPatientCard(
      {Key? key,
      required this.image,
      required this.name,
      required this.phone,
      required this.address,
      this.age,
      this.birthDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyles.tsHeading4(color: Palettes.kcNeutral1),
              ),
              SizedBox(height: 5),
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
          )
        ],
      ),
    );
  }
}
