import 'package:flutter/material.dart';

class ProcedureCard extends StatelessWidget {
  final String id;
  final String procedureName;
  final String? price;
  const ProcedureCard(
      {Key? key, required this.id, required this.procedureName, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //  Todo: design code for procedure card
      child: Text(procedureName),
    );
  }
}
