import 'package:dentalapp/ui/views/view_clinic_personnel/view_clinic_personner_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ViewClinicPersonnel extends StatelessWidget {
  const ViewClinicPersonnel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewClinicPersonnelViewModel>.reactive(viewModelBuilder:
        () => ViewClinicPersonnelViewModel(), builder:
    (context,model,widget)=>Scaffold(
      appBar: AppBar(
        title: Text('Clinic Personnel'),
        centerTitle: true,
      ),
      body: ListView(

      ),
    ),

    );
  }
}
