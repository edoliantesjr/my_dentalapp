import "package:charts_flutter/flutter.dart" as charts;
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/payment/payment.dart';

class SalesReportViewModel extends BaseViewModel {
  //
  final apiService = locator<ApiService>();

  List<Payment> paymentList = [];
  List<Sales> data = [];

  final firstDate = TextEditingController(text: '${DateTime.now().year}');
  final secondDate = TextEditingController(text: '${DateTime.now().year - 1}');

  @override
  void dispose() {
    firstDate.dispose();
    secondDate.dispose();
    super.dispose();
  }

  List<charts.Series<Sales, String>> setSeriesList() {
    return [
      charts.Series<Sales, String>(
        id: 'Year 1',
        data: data,
        measureFn: (Sales sales, _) => sales.sales,
        domainFn: (Sales sales, _) => sales.month,
        colorFn: (s, i) =>
            charts.ColorUtil.fromDartColor(Colors.orange.shade900),
        outsideLabelStyleAccessorFn: (Sales row, _) =>
            const charts.TextStyleSpec(fontSize: 8),
        labelAccessorFn: (Sales row, _) => row.sales.toString().toCurrency!,
      ),
      charts.Series<Sales, String>(
        id: 'Year 2',
        data: [
          Sales(
              month: DateFormat.MMM().format(
                DateTime(DateTime.now().year, 5),
              ),
              sales: 9000),
        ],
        measureFn: (Sales sales, _) => sales.sales,
        domainFn: (Sales sales, _) => sales.month,
        outsideLabelStyleAccessorFn: (Sales row, _) =>
            const charts.TextStyleSpec(fontSize: 8),
        labelAccessorFn: (Sales row, _) => row.sales.toString().toCurrency!,
      ),
    ];
  }

  void init() async {
    setBusy(true);
    await getAllPayments();
    computeJan();
    computeFeb();
    computeMar();
    computeApr();
    computeMay();
    computeJun();
    computeJul();
    computeAug();
    computeSep();
    computeOct();
    computeNov();
    computeDec();
    await Future.delayed(const Duration(seconds: 1));
    setBusy(false);
  }

  Future<void> getAllPayments() async {
    paymentList = await apiService.getAllPayments();
    notifyListeners();
  }

  void computeJan() {
    double total = 0;
    final janDate = DateTime(DateTime.now().year, 1);
    for (Payment payment in paymentList) {
      if (janDate.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final janData =
        Sales(month: DateFormat.MMM().format(janDate), sales: total);
    data.add(janData);
    notifyListeners();
  }

  void computeFeb() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 2);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final febData = Sales(month: DateFormat.MMM().format(date), sales: total);
    data.add(febData);
    notifyListeners();
  }

  void computeMar() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 3);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final marData = Sales(month: DateFormat.MMM().format(date), sales: total);
    data.add(marData);
    notifyListeners();
  }

  void computeApr() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 4);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final aprData = Sales(month: DateFormat.MMM().format(date), sales: total);
    data.add(aprData);
    notifyListeners();
  }

  void computeMay() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 5);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final mayData = Sales(month: DateFormat.MMM().format(date), sales: total);
    data.add(mayData);
    notifyListeners();
  }

  void computeJun() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 6);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeJul() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 7);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeAug() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 8);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeSep() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 9);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeOct() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 10);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeNov() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 11);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }

  void computeDec() {
    double total = 0;
    final date = DateTime(DateTime.now().year, 12);
    for (Payment payment in paymentList) {
      if (date.isSameDateMonth(payment.paymentDate.toDateTime()!)) {
        total += double.parse(payment.totalAmount);
      }
    }
    final data = Sales(month: DateFormat.MMM().format(date), sales: total);
    this.data.add(data);
    notifyListeners();
  }
}

class Sales {
  final String month;
  final double sales;

  const Sales({required this.month, required this.sales});
}
