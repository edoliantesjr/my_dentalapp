import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/select_dental_note_card/select_dental_note_card.dart';
import 'payment_select_dental_note_view_model.dart';

class PaymentSelectDentalNoteView extends StatelessWidget {
  final String patientId;
  const PaymentSelectDentalNoteView({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentSelectDentalNoteViewModel>.reactive(
      viewModelBuilder: () => PaymentSelectDentalNoteViewModel(),
      onModelReady: (model) => model.init(patientId),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Select Dental Note'),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          Container(
            color: Colors.white,
            width: double.maxFinite,
            child: ElevatedButton(
                onPressed: () => model.returnSelectedDentalNote(),
                child: const Text('Confirm')),
          )
        ],
        body: Form(
          key: model.dentalFormKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Unpaid Dental Note List',
                      style: TextStyles.tsHeading5(),
                    ),
                    const SizedBox(width: 2),
                    const Expanded(
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Palettes.kcPurpleMain,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Select All'),
                      Checkbox(
                        value: model.selectAll,
                        onChanged: (value) {
                          model.toogleSelectAll();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                model.isBusy
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 5),
                            Text('Loading Data...'),
                          ],
                        ),
                      )
                    : Expanded(
                        child: model.listOfUnpaidDentalNotes.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) =>
                                    SelectDentalNoteCard(
                                  dentalNote:
                                      model.listOfUnpaidDentalNotes[index],
                                  onChanged: () =>
                                      model.addToSelectedDentalNote(
                                          model.listOfUnpaidDentalNotes[index]),
                                  value: model.dentalNoteExistInSelectedNotes(
                                      model.listOfUnpaidDentalNotes[index].id),
                                  patientId: patientId,
                                  selectedDentalNotes: model.selectedDentalNote,
                                  listOfDentalNotes:
                                      model.listOfUnpaidDentalNotes,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                itemCount: model.listOfUnpaidDentalNotes.length,
                              )
                            : const Center(
                                child: Text('No Dental Notes Found...'),
                              )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
