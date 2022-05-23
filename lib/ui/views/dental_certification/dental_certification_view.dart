import 'package:dentalapp/ui/widgets/certificate_card/certificate_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';
import 'dental_certification_view_model.dart';

class DentalCertificationView extends StatelessWidget {
  final Patient patient;
  const DentalCertificationView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DentalCertification>.reactive(
      viewModelBuilder: () => DentalCertification(),
      onModelReady: (model) => model.listenToGetDentalCert(patient: patient),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text("Patient's Certification"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => model.goToAddCertificate(patient),
            label: Text('Add Dental Certificate')),
        body: ListView(
          padding: EdgeInsets.all(8),
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'List Of Patient Dental Certificates',
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
            model.dentalCertificates.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) => CertificateCard(
                        dentalCertificate: model.dentalCertificates[index],
                        onViewCertTap: () => model.openCertificate(
                            certificate: model.dentalCertificates[index],
                            patient: patient)),
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemCount: model.dentalCertificates.length,
                  )
                : Container(
                    height: 500,
                    child: Center(child: Text('No Saved Dental Certification')),
                  ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
