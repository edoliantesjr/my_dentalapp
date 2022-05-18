import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/select_dental_note/select_dental_note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/dental_note_card/dental_note_card.dart';

class SelectDentalNoteView extends StatelessWidget {
  final String patientId;
  const SelectDentalNoteView({Key? key, required this.patientId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Dental Note'),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
              onPressed: () {
                // todo
              },
              child: Text('Confirm')),
        )
      ],
      body: ViewModelBuilder<SelectDentalNoteViewModel>.reactive(
          viewModelBuilder: () => SelectDentalNoteViewModel(),
          onModelReady: (model) => model.init(patientId),
          builder: (context, model, widget) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Dental Note List',
                          style: TextStyles.tsHeading5(),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Palettes.kcPurpleMain,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      color: Colors.grey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Select All'),
                          Checkbox(
                            value: true,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    model.isBusy
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 5),
                                Text('Loading Data...'),
                              ],
                            ),
                          )
                        : Expanded(
                            child: model.listOfUnpaidDentalNotes.length > 0
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (context, index) =>
                                        CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          value: true,
                                          onChanged: (value) {},
                                          title: DentalNoteCard(
                                            dentalNotes: model
                                                .listOfUnpaidDentalNotes[index],
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 8),
                                    itemCount:
                                        model.listOfUnpaidDentalNotes.length)
                                : Center(
                                    child: Text('No Dental Notes Found...'),
                                  )),
                  ],
                ),
              )),
    );
  }
}
