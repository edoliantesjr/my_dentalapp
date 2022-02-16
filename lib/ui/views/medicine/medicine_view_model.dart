import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/medicine/medicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class MedicineViewModel extends BaseViewModel {
  //TODO: Logic code for medicine view
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? medicineStreamSub;
  List<Medicine> medicineList = [];

  bool isScrolledUp = false;
  bool searchMode = false;

  @override
  void dispose() {
    medicineStreamSub!.cancel();
    super.dispose();
  }

  void setFabSize(ScrollController scrollController) {
    scrollController.addListener(() {
      if (scrollController.offset > 50) {
        isScrolledUp = true;
        notifyListeners();
      } else {
        isScrolledUp = false;
        notifyListeners();
      }
    });
  }

  void getMedicineList() {
    apiService.getPatients().listen((event) {
      medicineStreamSub?.cancel();
      medicineStreamSub = apiService.getMedicineList().listen((medicine) {
        medicineList = medicine;
        notifyListeners();
      });
    });
  }

  void deleteMedicine(String medicineId) {
    //  Todo: logic code to delete medicine
  }

  void searchMedicine(String query) {
    //  Todo: search query for medicine
    if (searchMode == false) {
      searchMode = true;
      notifyListeners();
    }
  }
}
