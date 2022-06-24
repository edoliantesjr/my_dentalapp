import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/ui/views/add_expenses/add_expenses_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/font_name/font_name.dart';
import '../../../constants/styles/palette_color.dart';
import '../../../constants/styles/text_border_styles.dart';
import '../../../constants/styles/text_styles.dart';

class AddExpenseView extends StatelessWidget {
  const AddExpenseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddExpensesViewModel>.reactive(
      viewModelBuilder: () => AddExpensesViewModel(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Clinic Expenses'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                color: Colors.grey.shade500,
                width: 1,
              )),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ]),
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Expense Amount',
                        style: TextStyles.tsHeading5(),
                      ),
                      Text(
                        '${model.totalAmount}'.toCurrency!,
                        style: const TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 18,
                            fontFamily: FontNames.sfPro,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => model.performAddingExpense(),
                child: Container(
                  height: double.maxFinite,
                  color: Palettes.kcPurpleMain,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  alignment: Alignment.center,
                  child: Text(
                    'Save Expense',
                    style: TextStyles.tsButton1(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
          child: FloatingActionButton.extended(
              onPressed: model.goToAddExpenseItem, label: const Text('Add Item')),
        ),
        body: Form(
          key: model.addExpenseFormKey,
          child: Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () => model.selectDate(),
                  child: TextFormField(
                    controller: model.dateTxtController,
                    textInputAction: TextInputAction.next,
                    enabled: false,
                    validator: (value) =>
                        model.validatorService.validateDate(value!),
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        errorBorder: TextBorderStyles.errorBorder,
                        errorStyle: TextStyles.errorTextStyle,
                        disabledBorder: TextBorderStyles.normalBorder,
                        hintText: 'Select Date',
                        labelText: 'Expenditure date *',
                        labelStyle:
                            TextStyles.tsBody1(color: Palettes.kcNeutral1),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                          color: Palettes.kcBlueMain1,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'List of Items',
                      style: TextStyles.tsButton2(),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Divider(
                        height: 2,
                        color: Palettes.kcPurpleMain,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                model.listOfExpenseItem.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) => SizedBox(
                              height: 95,
                              child: Card(
                                elevation: 2,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 5,
                                      height: double.maxFinite - 1,
                                      decoration: const BoxDecoration(
                                          color: Palettes.kcDarkerBlueMain1,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4),
                                              bottomLeft: Radius.circular(4))),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'Item Name: ',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: model
                                                          .listOfExpenseItem[
                                                              index]
                                                          .itemName,
                                                      style: TextStyles
                                                          .tsButton2()),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Quantity: ',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text: model
                                                          .listOfExpenseItem[
                                                              index]
                                                          .itemQty
                                                          .toString(),
                                                      style: TextStyles
                                                          .tsButton2()),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            RichText(
                                                text: TextSpan(
                                                    text: 'Amount: ',
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: model
                                                          .listOfExpenseItem[
                                                              index]
                                                          .amount
                                                          .toString()
                                                          .toCurrency!,
                                                      style: TextStyles
                                                          .tsButton2(
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                      )),
                                                ])),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const VerticalDivider(
                                      color: Colors.grey,
                                      width: 2,
                                      thickness: 2,
                                    ),
                                    const VerticalDivider(
                                      color: Colors.white,
                                      width: 2,
                                      thickness: 2,
                                    ),
                                    GestureDetector(
                                      onTap: () => model.removeExpenseItem(
                                          model.listOfExpenseItem[index].id),
                                      child: Container(
                                        height: double.maxFinite - 1,
                                        width: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade800,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: model.listOfExpenseItem.length)
                    : Container(
                        color: Colors.grey.shade200,
                        height: 200,
                        child: const Center(child: Text('No Items Added')),
                      ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: model.noteTextController,
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  maxLength: 80,
                  decoration: const InputDecoration(
                    hintText: 'Type here',
                    labelText: 'Remark & Notes (Optional)',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle:
                        TextStyle(fontSize: 20, color: Palettes.kcNeutral1),
                    enabledBorder: TextBorderStyles.normalBorder,
                    focusedBorder: TextBorderStyles.focusedBorder,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
