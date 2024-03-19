class IdModel {
  String? status;
  List<Data>? data;

  IdModel({this.status, this.data});

  IdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? iid;
  String? vehicleNo;
  int? subiid;
  String? vechicleTyoe;

  Data({this.iid, this.vehicleNo, this.subiid, this.vechicleTyoe});

  Data.fromJson(Map<String, dynamic> json) {
    iid = json['iid'];
    vehicleNo = json['Vehicle_no'];
    subiid = json['Subiid'];
    vechicleTyoe = json['Vechicle_tyoe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iid'] = this.iid;
    data['Vehicle_no'] = this.vehicleNo;
    data['Subiid'] = this.subiid;
    data['Vechicle_tyoe'] = this.vechicleTyoe;
    return data;
  }
}