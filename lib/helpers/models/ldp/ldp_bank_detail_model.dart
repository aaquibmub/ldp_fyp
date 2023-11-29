import '../../db_helper.dart';

class LdpBankDetailModel {
  final int id;
  int numOfBankAccounts;
  int numOfCreditCards;
  double intrestRate;
  int numOfLoans;
  int delayedFromDueDate;

  LdpBankDetailModel(
    this.id,
    this.numOfBankAccounts,
    this.numOfCreditCards,
    this.intrestRate,
    this.numOfLoans,
    this.delayedFromDueDate,
  );
  factory LdpBankDetailModel.fromJson(dynamic json) {
    // final List<DropdownItem<int>> typesOfLoan = [];
    // final exItems = json['typesOfLoan'] as List<dynamic>;
    // if (exItems != null) {
    //   exItems.forEach((value) {
    //     DropdownItem<int> prod = DropdownItem<int>.fromJson((value));
    //     typesOfLoan.add(prod);
    //   });
    // }

    return LdpBankDetailModel(
      json['id'] as int,
      json['numOfBankAccounts'] as int,
      json['numOfCreditCards'] as int,
      json['intrestRate'] as double,
      json['numOfLoans'] as int,
      json['delayedFromDueDate'] as int,
    );
  }

  Map<String, dynamic> toJson() => ldpBankDetailModelToJson(this);

  Map<String, dynamic> ldpBankDetailModelToJson(
    LdpBankDetailModel instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'numOfBankAccounts': instance.numOfBankAccounts,
        'numOfCreditCards': instance.numOfCreditCards,
        'intrestRate': instance.intrestRate,
        'numOfLoans': instance.numOfLoans,
      };

  Map<String, dynamic> toDbMap() => ldpBankDetailModelToDbMap(this);

  Map<String, dynamic> ldpBankDetailModelToDbMap(
    LdpBankDetailModel instance,
  ) =>
      <String, dynamic>{
        // DbHelper.predictionId: instance.id,
        DbHelper.predictionNumOfBankAccounts: instance.numOfBankAccounts,
        DbHelper.predictionNumOfCreditCards: instance.numOfCreditCards,
        DbHelper.predictionIntrestRate: instance.intrestRate,
        DbHelper.predictionNumOfLoans: instance.numOfLoans,
        DbHelper.predictionDelayFormDueDate: instance.numOfLoans,
      };
}
