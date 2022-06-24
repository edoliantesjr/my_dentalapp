// ignore_for_file: deprecated_member_use

import 'package:dentalapp/constants/font_name/font_name.dart';
import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:dentalapp/ui/widgets/selection_dentist/selection_dentist_view_model.dart';
import 'package:dentalapp/ui/widgets/user_card/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SelectionDentist extends StatelessWidget {
  const SelectionDentist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionDentistViewModel>.reactive(
      viewModelBuilder: () => SelectionDentistViewModel(),
      onModelReady: (model) => model.searchDentist(''),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.maxFinite, 155),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Select Dentist',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: FontNames.gilRoy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) => model.searchDentist(value),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Palettes.kcBlueMain1,
                          width: 1.8,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(
                          color: Palettes.kcNeutral1,
                          width: 1,
                        ),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/icons/Search.svg',
                        ),
                      ),
                      constraints: const BoxConstraints(maxHeight: 43),
                      hintText: 'Search Dentist...',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('List of Dentist'),
                      Expanded(child: Divider())
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: Scrollbar(
            thickness: 7,
            hoverThickness: 2,
            showTrackOnHover: true,
            child: setDentistSelectionBody(
              isBusy: model.isBusy,
              dentistList: model.isBusy ? null : model.dentistList,
              onTap: (user) => model.setReturnDentist(user),
            ),
          ),
        ),
      ),
    );
  }

  Widget setDentistSelectionBody({
    required bool isBusy,
    required List<UserModel>? dentistList,
    required Function(UserModel user) onTap,
  }) {
    if (isBusy) {
      return Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            children: const [
              SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 4),
              Text('Loading..')
            ],
          ),
        ),
      );
    } else {
      if (dentistList!.isEmpty) {
        return const Center(
          child: Text('No Dentist Found...'),
        );
      } else {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => UserCard(
            user: dentistList[index],
            onTap: () => onTap(dentistList[index]),
          ),

          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          itemCount: dentistList.length,
          // padding: EdgeInsets.only(bottom: 20, top: 5),
        );
      }
    }
  }
}
