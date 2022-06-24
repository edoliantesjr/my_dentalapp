import 'package:dentalapp/ui/views/view_dental_note/view_dental_note_view_model.dart';
import 'package:dentalapp/ui/widgets/dental_note_card/dental_note_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../models/patient_model/patient_model.dart';

class ViewDentalNote extends StatelessWidget {
  final Patient patient;
  const ViewDentalNote({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewDentalNoteViewModel>.reactive(
      viewModelBuilder: () => ViewDentalNoteViewModel(),
      onModelReady: (model) => model.getDentalNotes(patient.id),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Treatment Records'),
        ),
        body: Container(
          color: const Color.fromARGB(143, 234, 218, 236),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Patient Treatment Records',
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Divider(
                      height: 2,
                      thickness: 2,
                      color: Palettes.kcDarkerBlueMain1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              model.isBusy
                  ? SizedBox(
                      height: 500,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Loading')
                        ],
                      )),
                    )
                  : model.dentalNotes.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) => DentalNoteCard(
                              dentalNote: model.dentalNotes[index],
                              patient: patient),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemCount: model.dentalNotes.length)
                      : const SizedBox(
                          height: 500,
                          child: Center(
                              child: Text('No Dental Notes/ Treatment Record')),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
