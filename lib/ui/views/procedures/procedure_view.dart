import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/procedures/procedure_view_model.dart';
import 'package:dentalapp/ui/widgets/procedure_card/procedure_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProceduresView extends StatelessWidget {
  const ProceduresView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProcedureViewModel>.reactive(
      viewModelBuilder: () => ProcedureViewModel(),
      onModelReady: (model) => model.getProcedureList(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Dental Procedures',
              style: TextStyles.tsHeading3(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
              heroTag: null,
              onPressed: () =>
                  model.navigationService.pushNamed(Routes.AddProcedureView),
              label: Text('Add Procedure')),
          body: ListView(
            children: [
              //  Todo: design code for procedure view
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => ProcedureCard(
                  procedureName: model.procedureList[index].procedureName,
                  id: model.procedureList[index].id!,
                ),
                separatorBuilder: (context, index) => Container(
                  height: 10,
                  color: Colors.grey.shade500,
                ),
                itemCount: model.procedureList.length,
              )
            ],
          )),
    );
  }
}
