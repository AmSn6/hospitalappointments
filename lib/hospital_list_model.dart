// To parse this JSON data, do
//
//     final hospitalListModel = hospitalListModelFromJson(jsonString);

import 'dart:convert';

HospitalListModel hospitalListModelFromJson(String str) => HospitalListModel.fromJson(json.decode(str));

String hospitalListModelToJson(HospitalListModel data) => json.encode(data.toJson());

class HospitalListModel {
  HospitalListModel({
    this.hospitalList,
    this.success,
    this.message,
  });

  List<HospitalList> hospitalList;
  int success;
  String message;

  factory HospitalListModel.fromJson(Map<String, dynamic> json) => HospitalListModel(
    hospitalList: json["hospital_list"] == null ? null : List<HospitalList>.from(json["hospital_list"].map((x) => HospitalList.fromJson(x))),
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hospital_list": hospitalList == null ? null : List<dynamic>.from(hospitalList.map((x) => x.toJson())),
    "success": success == null ? null : success,
    "message": message == null ? null : message,
  };
}

class HospitalList {
  HospitalList({
    this.hospitalId,
    this.hospital,
    this.hospitalIcon,
  });

  String hospitalId;
  String hospital;
  String hospitalIcon;

  factory HospitalList.fromJson(Map<String, dynamic> json) => HospitalList(
    hospitalId: json["hospital_id"] == null ? null : json["hospital_id"],
    hospital: json["hospital"] == null ? null : json["hospital"],
    hospitalIcon: json["hospital_icon"] == null ? null : json["hospital_icon"],
  );

  Map<String, dynamic> toJson() => {
    "hospital_id": hospitalId == null ? null : hospitalId,
    "hospital": hospital == null ? null : hospital,
    "hospital_icon": hospitalIcon == null ? null : hospitalIcon,
  };
}
