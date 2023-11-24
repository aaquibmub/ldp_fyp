import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:ldp_fyp/helpers/models/ldp/ldp_information-model.dart';

import '../helpers/models/common/dropdown_item.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/user.dart';

class LoanProvider with ChangeNotifier {
  final User user;

  LoanProvider(
    this.user,
  );

  List<DropdownItem<int>> _occupationList = [];

  List<DropdownItem<int>> get occupationList {
    return _occupationList;
  }

  Future<void> getOccupationDropDownList() async {
    try {
      final dbOccupations =
          (await DbHelper.instance.getData(DbHelper.tblOccupation)).toList();
      final List<DropdownItem<int>> occupationList = [];
      dbOccupations.forEach((e) {
        occupationList.add(DropdownItem(
          e[DbHelper.occupationId] as int,
          e[DbHelper.occupationName] as String,
        ));
      });

      _occupationList = occupationList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseModel<String>> createPrediction(
      LdpInformationModel model) async {
    try {
      var id = await DbHelper.instance.insert(
        DbHelper.tblPrediction,
        model.toDbMap(),
      );
      return ResponseModel(id.toString(), '', false);
    } catch (error) {
      return ResponseModel(null, error.toString(), true);
    }
  }
}
