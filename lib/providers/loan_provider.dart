import 'package:flutter/material.dart';
import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:ldp_fyp/helpers/models/ldp/ldp_information-model.dart';

import '../helpers/models/common/dropdown_item.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/ldp/ldp_bank_detail_model.dart';
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

  List<DropdownItem<int>> _typeOfLoanList = [];

  List<DropdownItem<int>> get typeOfLoanList {
    return _typeOfLoanList;
  }

  Future<void> getTypeOfLoanDropDownList() async {
    try {
      final dbtypeOfLoans =
          (await DbHelper.instance.getData(DbHelper.tblTypeOfLoan)).toList();
      final List<DropdownItem<int>> typeOfLoanList = [];
      dbtypeOfLoans.forEach((e) {
        typeOfLoanList.add(DropdownItem(
          e[DbHelper.typeOfLoanId] as int,
          e[DbHelper.typeOfLoanName] as String,
        ));
      });

      _typeOfLoanList = typeOfLoanList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<ResponseModel<int>> createPrediction(LdpInformationModel model) async {
    try {
      var id = await DbHelper.instance.insert(
        DbHelper.tblPrediction,
        model.toDbMap(),
      );
      return ResponseModel(id, '', false);
    } catch (error) {
      return ResponseModel(null, error.toString(), true);
    }
  }

  Future<ResponseModel<int>> updatePredictionBankDetails(
    LdpBankDetailModel model,
  ) async {
    try {
      var id = await DbHelper.instance.update(
        DbHelper.tblPrediction,
        model.toDbMap(),
        model.id,
      );
      model.typesOfLoan.forEach((f) async => {
            await DbHelper.instance.insert(
              DbHelper.tblPredictionAndTypeOfLoan,
              {
                DbHelper.predictionAndTypeOfLoanTypeId: f.value,
                DbHelper.predictionAndTypeOfLoanPredictionId: model.id,
              },
            )
          });
      return ResponseModel(id, '', false);
    } catch (error) {
      return ResponseModel(null, error.toString(), true);
    }
  }

  Future<double> getPredictionResult(int pid) async {
    try {
      final dbPredications = (await DbHelper.instance
          .getFirstOrDefault(DbHelper.tblPrediction, pid));
      return 26;
    } catch (error) {
      throw error;
    }
  }
}
