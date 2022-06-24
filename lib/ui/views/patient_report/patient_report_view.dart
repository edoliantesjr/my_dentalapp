import 'package:charts_flutter/flutter.dart';
import 'package:dentalapp/ui/views/patient_report/patient_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class PatientReportView extends StatelessWidget {
  const PatientReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientReportViewModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => PatientReportViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Patient Report'),
        ),
        body: SafeArea(
          child: model.isBusy
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 5),
                      Text("Loading Data. Please wait...")
                    ],
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total Patients: \n' + model.totalPatients.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        width: 400,
                        child: charts.PieChart(
                          model.setSeriesList(),
                          animate: true,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.pink,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Female:'
                                    ' ${model.totalFemalePatients.toString()}',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    '${((model.totalFemalePatients / model.totalPatients) * 100).toStringAsFixed(2)}%',
                                    style: GoogleFonts.merriweather(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Male:'
                                    ' ${model.totalMalePatients.toString()}',
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    '${((model.totalMalePatients / model.totalPatients) * 100).toStringAsFixed(2)}%',
                                    style: GoogleFonts.merriweather(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
