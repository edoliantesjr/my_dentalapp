import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/dental_notes/dental_notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles/text_styles.dart';

class DentalNoteCard extends StatelessWidget {
  final DentalNotes dentalNotes;
  const DentalNoteCard({Key? key, required this.dentalNotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Checkbox(
                //   activeColor: Palettes.kcBlueMain1,
                //   onChanged: (bool? value) {}, value: true,
                // ),
                Text(
                  dentalNotes.selectedTooth,
                  style: TextStyles.tsHeading4(),
                ),
                Text(dentalNotes.procedure.procedureName),
                Text(DateFormat.yMd()
                    .add_jm()
                    .format(dentalNotes.date.toDateTime()!)),
                Text('Unpaid'),
                Text(dentalNotes.note),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
