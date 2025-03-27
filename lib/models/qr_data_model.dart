import 'dart:convert';

import 'package:get/get.dart';

class QrDataModel {
  int? id;
  String value;
  String createAt;
  int? status;
  RxBool? isExpanded = false.obs;

  QrDataModel(
      {required this.value, required this.createAt, this.id, this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': id,
      'VALUE': value,
      'CREATE_AT': createAt,
      'STATUS': status,
    };
  }

  factory QrDataModel.fromMap(Map<String, dynamic> map) {
    return QrDataModel(
      id: map['ID'] != null ? map['ID'] as int : null,
      value: map['VALUE'] as String,
      createAt: map['CREATE_AT'] as String,
      status: map['STATUS'] != null ? map['STATUS'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrDataModel.fromJson(String source) =>
      QrDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
