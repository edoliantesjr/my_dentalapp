import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/procedures/procedure_view_model.dart';
import 'package:dentalapp/ui/widgets/procedure_card/procedure_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProceduresView extends StatefulWidget {
  const ProceduresView({Key? key}) : super(key: key);

  @override
  State<ProceduresView> createState() => _ProceduresViewState();
}

class _ProceduresViewState extends State<ProceduresView> {
  final procedureScrollController = ScrollController();
  final searchProcedureTxtController = TextEditingController();

  @override
  void dispose() {
    procedureScrollController.dispose();
    searchProcedureTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProcedureViewModel>.reactive(
      viewModelBuilder: () => ProcedureViewModel(),
      onModelReady: (model) {
        model.getProcedureList();
        model.setFabSize(procedureScrollController);
      },
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Dental Procedures',
              style: TextStyles.tsHeading3(color: Colors.white),
            ),
          ),
          floatingActionButton: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            child: model.isScrolledUp
                ? FloatingActionButton(
                    onPressed: () => model.navigationService
                        .pushNamed(Routes.AddProcedureView),
                    child: Icon(Icons.add),
                  )
                : FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () => model.navigationService
                        .pushNamed(Routes.AddProcedureView),
                    label: Text('Add Procedure'),
                  ),
          ),
          body: ListView(
            controller: procedureScrollController,
            children: [
              //  Todo: design code for procedure view
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) => ProcedureCard(
                  procedureName: model.procedureList[index].procedureName,
                  id: model.procedureList[index].id!,
                  price: model.procedureList[index].priceToCurrency,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 10,
                  color: Colors.grey.shade300,
                ),
                itemCount: model.procedureList.length,
              )
            ],
          )),
    );
  }
}
