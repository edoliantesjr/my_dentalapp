import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastServiceImpl extends ToastService {
  @override
  Future<void> showToast({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Color(0xead50000),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
