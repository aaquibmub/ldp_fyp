import '../../db_helper.dart';

class LdpCreditDetailModel {
  final int id;
  int numOfDelayedPayment;
  double changedCreditLimit;
  int numOfCreditInquiries;
  int creditMix;
  double creditUtilizationRatio;
  int creditHistoryAge;
  double monthlyBalance;

  LdpCreditDetailModel(
    this.id,
    this.numOfDelayedPayment,
    this.changedCreditLimit,
    this.numOfCreditInquiries,
    this.creditMix,
    this.creditUtilizationRatio,
    this.creditHistoryAge,
    this.monthlyBalance,
  );
  factory LdpCreditDetailModel.fromJson(dynamic json) {
    return LdpCreditDetailModel(
      json['id'] as int,
      json['numOfDelayedPayment'] as int,
      json['changedCreditLimit'] as double,
      json['numOfCreditInquiries'] as int,
      json['creditMix'] as int,
      json['creditUtilizationRatio'] as double,
      json['creditHistoryAge'] as int,
      json['monthlyBalance'] as double,
    );
  }

  Map<String, dynamic> toJson() => ldpCreditDetailModelToJson(this);

  Map<String, dynamic> ldpCreditDetailModelToJson(
    LdpCreditDetailModel instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'numOfDelayedPayment': instance.numOfDelayedPayment,
        'changedCreditLimit': instance.changedCreditLimit,
        'numOfCreditInquiries': instance.numOfCreditInquiries,
        'creditMix': instance.creditMix,
        'creditUtilizationRatio': instance.creditUtilizationRatio,
        'creditHistoryAge': instance.creditHistoryAge,
        'monthlyBalance': instance.monthlyBalance,
      };

  Map<String, dynamic> toDbMap() => ldpCreditDetailModelToDbMap(this);

  Map<String, dynamic> ldpCreditDetailModelToDbMap(
    LdpCreditDetailModel instance,
  ) =>
      <String, dynamic>{
        // DbHelper.predictionId: instance.id,
        DbHelper.predictionNumberofDelayedPayment: instance.numOfDelayedPayment,
        DbHelper.predictionChangedCreditLimit: instance.changedCreditLimit,
        DbHelper.predictionNumberofCreditInquiries:
            instance.numOfCreditInquiries,
        DbHelper.predictionCreditMix: instance.creditMix,
        DbHelper.predictionCreditUtilizationRatio:
            instance.creditUtilizationRatio,
        DbHelper.predictionCreditHistoryAge: instance.creditHistoryAge,
        DbHelper.predictionMonthlyBalance: instance.monthlyBalance,
      };
}
