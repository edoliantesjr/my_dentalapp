import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:dentalapp/constants/styles/text_styles.dart';
import 'package:dentalapp/ui/widgets/selection_list/selection_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class SelectionList extends StatelessWidget {
  final List<String> options;

  const SelectionList({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SelectionListViewModel>.reactive(
        viewModelBuilder: () => SelectionListViewModel(),
        builder: (context, model, child) => ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Palettes.kcHintColor))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: Get.back,
                          child: Text(
                            'Cancel',
                            style: TextStyles.tsButton1(color: Colors.red[700]),
                          ),
                        ),
                        TextButton(
                          onPressed: () => model.setReturnOption(options),
                          child: Text(
                            'Done',
                            style: TextStyles.tsButton1(
                                color: Palettes.kcBlueMain1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: CupertinoPicker(
                      scrollController: model.scrollController,
                      onSelectedItemChanged: (index) =>
                          model.setSelectedOption(options, index),
                      children: options
                          .map((option) => Center(
                                child: Text(
                                  option,
                                  style: TextStyles.tsBody1(),
                                ),
                              ))
                          .toList(),
                      selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                        background: Palettes.kcBlueMain1.withOpacity(0.2),
                      ),
                      diameterRatio: 15,
                      itemExtent: 50,
                    ),
                  ),
                ],
              ),
            ));
  }
}
