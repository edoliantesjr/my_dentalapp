import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/views/medicine/medicine_view_model.dart';
import 'package:dentalapp/ui/widgets/medicine_card/medicine_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';

class MedicineView extends StatefulWidget {
  const MedicineView({Key? key}) : super(key: key);

  @override
  State<MedicineView> createState() => _MedicineViewState();
}

class _MedicineViewState extends State<MedicineView> {
  final medicineScrollController = ScrollController();
  final searchMedicineTxtController = TextEditingController();

  @override
  void dispose() {
    medicineScrollController.dispose();
    searchMedicineTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MedicineViewModel>.reactive(
      viewModelBuilder: () => MedicineViewModel(),
      onModelReady: (model) {
        model.getMedicineList();
        model.setFabSize(medicineScrollController);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Medicine List',
            style: TextStyles.tsHeading3(color: Colors.white),
          ),
        ),
        floatingActionButton: AnimatedContainer(
          duration: Duration(milliseconds: 400),
          child: model.isScrolledUp
              ? FloatingActionButton(
                  onPressed: () =>
                      model.navigationService.pushNamed(Routes.AddMedicineView),
                  child: Icon(Icons.add),
                )
              : FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () =>
                      model.navigationService.pushNamed(Routes.AddMedicineView),
                  label: Text('Add Medicine'),
                ),
        ),
        body: ListView(
          controller: medicineScrollController,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            Container(
              height: 50,
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      // onChanged: (value) => model.searchPatient(value),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Palettes.kcBlueMain1,
                            width: 1.8,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: BorderSide(
                            color: Palettes.kcBlueDark,
                            width: 1,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: SvgPicture.asset(
                            'assets/icons/Search.svg',
                          ),
                        ),
                        constraints: BoxConstraints(maxHeight: 43),
                        hintText: 'Search Medicine...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Drugs List',
                  style: TextStyles.tsBody4(color: Colors.grey.shade800),
                ),
                SizedBox(width: 4),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.medicineList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                mainAxisExtent: 150,
              ),
              itemBuilder: (context, index) => MedicineCard(
                id: 'id',
                name: model.medicineList[index].medicineName,
                brandName: model.medicineList[index].brandName,
                price: model.medicineList[index].price,
                image: model.medicineList[index].image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
