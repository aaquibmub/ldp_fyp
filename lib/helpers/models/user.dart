import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class User {
  final String id;
  final String userName;
  final String email;

  User({
    @required this.id,
    @required this.userName,
    this.email,
  });

  factory User.fromJson(dynamic json) => User(
        id: json['id'] as String,
        userName: json['userName'] as String,
        email: json['email'] as String,
      );
  Map<String, dynamic> toJson() => userToJson(this);

  Map<String, dynamic> userToJson(
    User instance,
  ) =>
      <String, dynamic>{
        'id': instance.id,
        'userName': instance.userName,
        'email': instance.email,
      };
}
