import 'package:dentalapp/ui/views/expenses_report/expenses_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ExpensesReportView extends StatelessWidget {
  const ExpensesReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExpensesReportViewModel>.reactive(
      viewModelBuilder: () => ExpensesReportViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Expenses Report'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                'Expenses Report',
                style: GoogleFonts.quicksand(
                  fontSize: 28,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Scroll horizontally to show more',
                style: TextStyle(color: Colors.grey.shade700),
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
                            SizedBox(height: 5),
                            Text("Loading Data. Please wait...")
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Scrollbar(
                        thickness: 10,
                        thumbVisibility: true,
                        controller: null,
                        radius: const Radius.circular(20),
                        child: Container(
                          color: Colors.grey.shade100,
                          padding: const EdgeInsets.all(6.0),
                          child: ListView(
                            primary: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 38,
                                child: charts.BarChart(
                                  model.setSeriesList(),
                                  vertical: false,
                                  animate: true,
                                  barRendererDecorator:
                                      new charts.BarLabelDecorator<String>(),
                                  domainAxis: new charts.OrdinalAxisSpec(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
