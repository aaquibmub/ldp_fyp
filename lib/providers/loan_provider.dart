import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:ldp_fyp/helpers/models/ldp/ldp_information-model.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

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

  // List<DropdownItem<int>> _typeOfLoanList = [];

  // List<DropdownItem<int>> get typeOfLoanList {
  //   return _typeOfLoanList;
  // }

  // Future<void> getTypeOfLoanDropDownList() async {
  //   try {
  //     final dbtypeOfLoans =
  //         (await DbHelper.instance.getData(DbHelper.tblTypeOfLoan)).toList();
  //     final List<DropdownItem<int>> typeOfLoanList = [];
  //     dbtypeOfLoans.forEach((e) {
  //       typeOfLoanList.add(DropdownItem(
  //         e[DbHelper.typeOfLoanId] as int,
  //         e[DbHelper.typeOfLoanName] as String,
  //       ));
  //     });

  //     _typeOfLoanList = typeOfLoanList;
  //     notifyListeners();
  //   } catch (error) {
  //     throw error;
  //   }
  // }

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
      // model.typesOfLoan.forEach((f) async => {
      //       await DbHelper.instance.insert(
      //         DbHelper.tblPredictionAndTypeOfLoan,
      //         {
      //           DbHelper.predictionAndTypeOfLoanTypeId: f.value,
      //           DbHelper.predictionAndTypeOfLoanPredictionId: model.id,
      //         },
      //       )
      //     });
      return ResponseModel(id, '', false);
    } catch (error) {
      return ResponseModel(null, error.toString(), true);
    }
  }

  Future<double> getPredictionResult(int pid) async {
    try {
      // final rawCsvContent =
      //     await rootBundle.loadString('assets/Dataset-preprocessed.csv');
      // final samples = DataFrame.fromRawCsv(
      //   rawCsvContent,
      //   headerExists: true,
      // ).shuffle();
      // final rawCsvContent =
      //     await rootBundle.loadString('assets/Dataset-preprocessed.csv');
      // final samples = DataFrame.fromRawCsv(rawCsvContent);
      // final model = DecisionTreeClassifier(
      //   samples,
      //   'Credit_Score',
      //   minError: 0.3,
      //   minSamplesCount: 5,
      //   maxDepth: 4,
      // );
      // final targetName = 'Credit_Score';
      // final splits = splitData(samples, [0.8]);
      // final trainData = splits[0];
      // final testData = splits[1];
      // final model = LinearRegressor(trainData, targetName);
      // final error = model.assess(testData, MetricType.mape);
      // print(error);

      final dbPredications = (await DbHelper.instance
          .getFirstOrDefault(DbHelper.tblPrediction, pid));
      if (dbPredications == null) {
        return 100;
      }
      // Directory appDocDir = await getApplicationDocumentsDirectory();
      // String appDocPath = appDocDir.path;
      // await model.saveAsJson('$appDocPath/housing_model.json');
      // final file = File('$appDocPath/housing_model.json');
      // final encodedModel = await file.readAsString();
      // final model = LinearRegressor.fromJson(encodedModel);
      final json = await getModelJson();
      final encodedModel = jsonEncode(json);
      final classifier1 = LogisticRegressor.fromJson(encodedModel);
      // final classifier1 = LinearRegressor.fromJson(encodedModel);
      // final prediction = classifier1.predict(DataFrame.fromJson({
      //   'Employed': 1,
      // }));
      final csvString =
          "Age,Occupation,Annual_Income,Monthly_Inhand_Salary,Num_Bank_Accounts,Num_Credit_Card,Interest_Rate,Num_of_Loan,Delay_from_due_date,Num_of_Delayed_Payment,Changed_Credit_Limit,Num_Credit_Inquiries,Credit_Mix,Credit_Utilization_Ratio,Credit_History_Age,Monthly_Balance\n" +
              "23,1,19114.12,1824.843333,3,4,3,4,3,7,11.27,4,1,26.82261962,265,312.4940887\n" +
              "23,1,19114.12,1824.843333,3,4,3,4,3,4,11.27,4,1,31.94496006,266,284.6291625\n" +
              "23,1,19114.12,1824.843333,3,4,3,4,3,7,11.27,4,1,28.60935202,267,331.2098629";
      final dataFrame = DataFrame.fromRawCsv(csvString);
      final prediction = classifier1.predict(dataFrame);

      print(prediction.header); // ('class variable (0 or 1)')
      print(prediction.rows.toList());

      print(prediction.toJson());

//       // age
//       final age = dbPredications[DbHelper.predictionAge] as int;
//       double ageScore = 0;
//       final ageRanges = await DbHelper.instance.getData(DbHelper.tblAgeRange);

//       final ageRange = ageRanges
//           .where((w) =>
//               age >= w[DbHelper.ageRangeStart] && age < w[DbHelper.ageRangeEnd])
//           .first;

//       if (ageRange != null) {
//         ageScore = double.parse(ageRange[DbHelper.ageRangeScore].toString());
//       }

//       // occupation
//       final occupationId =
//           dbPredications[DbHelper.predictionOccupationId] as int;
//       double occupationScore = 0;
//       final occupations =
//           await DbHelper.instance.getData(DbHelper.tblOccupation);

//       final occupation = occupations
//           .where((w) => occupationId == w[DbHelper.occupationId])
//           .first;

//       if (occupation != null) {
//         occupationScore =
//             double.parse(occupation[DbHelper.occupationScore].toString());
//       }

// // annual income
//       final annualIncome = double.parse(
//           dbPredications[DbHelper.predictionAnnualIncome].toString());
//       double annualIncomeScore = 0;
//       final annualIncomeRanges =
//           await DbHelper.instance.getData(DbHelper.tblAnnualIncomeRange);

//       final annualIncomeRange = annualIncomeRanges
//           .where((w) =>
//               annualIncome >= w[DbHelper.annualIncomeRangeStart] &&
//               annualIncome < w[DbHelper.annualIncomeRangeEnd])
//           .first;

//       if (annualIncomeRange != null) {
//         ageScore = double.parse(
//             annualIncomeRange[DbHelper.annualIncomeRangeScore].toString());
//       }

//       return (ageScore + occupationScore + annualIncomeScore) / 3;
      return 0;
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> getModelJson() async {
    final rawCsvContent = await rootBundle.loadString('assets/Dataset-1.csv');
    final samples = DataFrame.fromRawCsv(rawCsvContent);
    final targetColumnName = 'Credit_Score';

    final splits = splitData(samples, [0.7]);
    final validationData = splits[0];
    final testData = splits[1];

    final validator = CrossValidator.kFold(validationData, numberOfFolds: 5);
    final createClassifier = (DataFrame samples) => LogisticRegressor(
          samples,
          targetColumnName,
        );

    final scores =
        await validator.evaluate(createClassifier, MetricType.accuracy);

    final accuracy = scores.mean();

    print('accuracy on k fold validation: ${accuracy.toStringAsFixed(2)}');

    final testSplits = splitData(testData, [0.8]);
    final classifier = createClassifier(testSplits[0]);
    final finalScore = classifier.assess(testSplits[1], MetricType.accuracy);

    print(finalScore.toStringAsFixed(2));

    final json = classifier.toJson();
    return json;
  }
}
