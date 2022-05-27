import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/ui/views/patient_drawer/patient_drawer_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/font_name/font_name.dart';
import '../../../models/patient_model/patient_model.dart';

class PatientDrawerView extends StatelessWidget {
  final Patient patient;

  const PatientDrawerView({required this.patient, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientDrawerViewModel>.reactive(
        viewModelBuilder: () => PatientDrawerViewModel(),
        builder: (context, model, widget) {
          return Drawer(
            child: Material(
                color: Palettes.kcDarkerBlueMain1,
                child: ListView(
                  children: [
                    DrawerHeader(
                      name: patient.fullName,
                      email: FirebaseAuth.instance.currentUser!.email ??
                          'No Email Address',
                      imageUrl: patient.image,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          DrawerItem(
                              btnText: 'View Clinic Appointments',
                              btnIcon: Icons.schedule,
                              onBtnTap: () => model.goToClinicAppointment()),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          DrawerItem(
                              btnText: 'View Clinic Personnel',
                              btnIcon: Icons.people_alt,

                              onBtnTap: () => model.goToClinicPersonnel()),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          DrawerItem(
                            btnText: 'View Clinic Offered Procedures',
                            btnIcon: Icons.medical_services,
                            onBtnTap: () => model.goClinicProcedures(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: Colors.white, thickness: 2),
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          DrawerItem(
                            btnText: 'Logout',
                            btnIcon: Icons.logout,
                            onBtnTap: () => model.logOut(),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}

///Drawer Header
class DrawerHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const DrawerHeader(
      {required this.name,
      required this.email,
      required this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 8, left: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(150),
                border: Border.all(color: Colors.white, width: 3)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: Text('User photo'),
                ),
                fit: BoxFit.cover,
                height: 140,
                width: 140,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              fontFamily: FontNames.sfPro,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

///Drawer Item
class DrawerItem extends StatelessWidget {
  final String btnText;
  final IconData btnIcon;
  final VoidCallback onBtnTap;

  const DrawerItem(
      {required this.btnText,
      required this.btnIcon,
      required this.onBtnTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        btnIcon,
        color: Colors.white,
      ),
      title: Text(btnText, style: TextStyle(color: Colors.white, fontSize: 16)),
      hoverColor: null,
      onTap: () => onBtnTap(),
    );
  }
}
