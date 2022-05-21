import 'package:dentalapp/ui/views/finance/finance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FinanceView extends StatelessWidget {
  const FinanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinanceViewModel>.reactive(
      viewModelBuilder: () => FinanceViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Finance'),
        ),
      ),
    );
  }
}
