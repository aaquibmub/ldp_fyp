import 'package:ldp_fyp/helpers/db_helper.dart';
import 'package:ldp_fyp/helpers/models/common/dropdown_item.dart';

class LdpInformationModel {
  final int id;
  String name;
  int age;
  DropdownItem<int> occupation;
  double annualIncome;
  double monthlySalary;

  LdpInformationModel(
    this.id,
    this.name,
    this.age,
    this.occupation,
    this.annualIncome,
    this.monthlySalary,
  );
  factory LdpInformationModel.fromJson(dynamic json) => LdpInformationModel(
        json['id'] as int,
        json['name'] as String,
        json['age'] as int,
        DropdownItem<int>.fromJson(json['occupation']),
        json['annualIncome'] as double,
        json['monthlySalary'] as double,
      );

  Map<String, dynamic> toJson() => ldpInformationModelToJson(this);

  Map<String, dynamic> ldpInformationModelToJson(
    LdpInformationModel instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'name': instance.name,
        'age': instance.age,
        'occupation': {
          'value': instance.occupation.value,
          'text': instance.occupation.text,
        },
        'annualIncome': instance.annualIncome,
        'monthlySalary': instance.monthlySalary,
      };

  Map<String, dynamic> toDbMap() => ldpInformationModelToDbMap(this);

  Map<String, dynamic> ldpInformationModelToDbMap(
    LdpInformationModel instance,
  ) =>
      <String, dynamic>{
        // DbHelper.predictionId: instance.id,
        DbHelper.predictionName: instance.name,
        DbHelper.predictionAge: instance.age,
        DbHelper.predictionOccupationId:
            instance.occupation != null ? instance.occupation.value : 0,
        DbHelper.predictionAnnualIncome: instance.annualIncome,
        DbHelper.predictionMonthlyInHandSalary: instance.monthlySalary,
      };
}
