import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dentalapp/ui/views/sales_report/sales_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class SalesReportsView extends StatelessWidget {
  const SalesReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SalesReportViewModel>.reactive(
      viewModelBuilder: () => SalesReportViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Income Report'),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Select Year"),
                                  content: SizedBox(
                                    // Need to use container to add size constraint.
                                    width: 300,
                                    height: 300,
                                    child: YearPicker(
                                      firstDate:
                                          DateTime(DateTime.now().year - 50, 1),
                                      lastDate:
                                          DateTime(DateTime.now().year + 50, 1),
                                      initialDate: DateTime.now(),
                                      // save the selected date to _selectedDate DateTime variable.
                                      // It's used to set the previous selected date when
                                      // re-showing the dialog.
                                      selectedDate: DateTime.now(),
                                      onChanged: (DateTime dateTime) {
                                        // close the dialog when year is selected.
                                        Navigator.pop(context);

                                        // Do something with the dateTime selected.
                                        // Remember that you need to use dateTime.year to get the year
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: TextFormField(
                            controller: model.firstDate,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Enter Year',
                                label: const Text('Select Year'),
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'COMPARE',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          // onTap: () =>
                          //     model.setBirthDateValue(birthDateTxtController),
                          child: TextFormField(
                            controller: model.secondDate,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                errorBorder: TextBorderStyles.errorBorder,
                                errorStyle: TextStyles.errorTextStyle,
                                disabledBorder: TextBorderStyles.normalBorder,
                                hintText: 'Enter Year',
                                label: const Text('Select Year'),
                                labelStyle: TextStyles.tsBody1(
                                    color: Palettes.kcNeutral1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 24,
                                  color: Palettes.kcBlueMain1,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        color: Colors.orange.shade900,
                      ),
                      const SizedBox(width: 4),
                      Text(model.firstDate.text),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 4),
                      Text(model.secondDate.text),
                    ],
                  ),
                  const SizedBox(height: 8),
                  model.isBusy
                      ? SizedBox(
                          height: 500,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                SizedBox(height: 5),
                                Text("Loading Data. Please wait...")
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.grey.shade100,
                          padding: const EdgeInsets.all(6),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 38,
                                child: charts.BarChart(
                                  model.setSeriesList(),
                                  animate: true,
                                  vertical: false,
                                  barRendererDecorator:
                                      charts.BarLabelDecorator<String>(),
                                  domainAxis: const charts.OrdinalAxisSpec(),
                                  defaultInteractions: !MediaQuery.of(context)
                                      .accessibleNavigation,
                                  behaviors: [
                                    charts.DomainA11yExploreBehavior(
                                      exploreModeTrigger:
                                          charts.ExploreModeTrigger.pressHold,
                                      exploreModeEnabledAnnouncement:
                                          'Explore mode enabled',
                                      exploreModeDisabledAnnouncement:
                                          'Explore mode disabled',
                                      minimumWidth: 1.0,
                                    ),
                                    charts.DomainHighlighter(
                                        charts.SelectionModelType.info),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
