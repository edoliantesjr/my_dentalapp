import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/ui/views/view_clinic_personnel/view_clinic_personner_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class ViewClinicPersonnel extends StatelessWidget {
  const ViewClinicPersonnel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewClinicPersonnelViewModel>.reactive(
      viewModelBuilder: () => ViewClinicPersonnelViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Clinic Personnel'),
          centerTitle: true,
        ),
        body: Container(
          color: Color.fromARGB(134, 184, 170, 189),
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
//
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Clinic Personnel',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Divider(
                      height: 2,
                      thickness: 2,
                      color: Palettes.kcDarkerBlueMain1,
                    ),
                  )
                ],
              ),

              SizedBox(height: 10),
              model.isBusy
                  ? Container(
                      height: 500,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text('Loading..')
                        ],
                      ),
                    )
                  : model.personnels.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) => Card(
                                elevation: 4,
                                margin: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 10,
                                          bottom: 8,
                                          top: 10,
                                          right: 0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: model.personnels[index]
                                                              .active_status
                                                              .toString()
                                                              .toUpperCase() ==
                                                          'ACTIVE'
                                                      ? Palettes.kcBlueMain1
                                                      : Colors.grey,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: model
                                                    .personnels[index].image,
                                                height: 60,
                                                width: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      model.personnels[index]
                                                          .fullName
                                                          .toUpperCase(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 13.5.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                        color: Palettes
                                                            .kcBlueMain1,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        100),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        100))),
                                                    child: Text(
                                                      model.personnels[index]
                                                          .position
                                                          .toUpperCase(),
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: model
                                                                .personnels[
                                                                    index]
                                                                .active_status
                                                                .toUpperCase() ==
                                                            'ACTIVE'
                                                        ? Palettes
                                                            .kcCompleteColor
                                                        : Colors.grey.shade600,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                  model.personnels[index]
                                                      .active_status
                                                      .toUpperCase(),
                                                  style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.email,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      model.personnels[index]
                                                          .email,
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      model.personnels[index]
                                                          .phoneNum
                                                          .toUpperCase(),
                                                      style: GoogleFonts.roboto(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(6),
                                              bottomRight: Radius.circular(6))),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => model.call(model
                                                  .personnels[index].phoneNum),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    4))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.call_rounded,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Call',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => model.text(model
                                                  .personnels[index].phoneNum),
                                              child: Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Colors
                                                        .blueGrey.shade700,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    4))),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.sms,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Send SMS',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: model.personnels.length)
                      : Container(
                          height: 500,
                          child: Center(
                              child: Text(model.isBusy
                                  ? 'Fetching Data'
                                  : 'No Personnel Found')),
                        ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
