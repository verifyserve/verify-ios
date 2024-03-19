class ShowVehicleModel {
  int? iid;
  String? vehicleNo;
  int? subiid;

  ShowVehicleModel({this.iid, this.vehicleNo, this.subiid});

  ShowVehicleModel.fromJson(Map<String, dynamic> json) {
    iid = json['iid'];
    vehicleNo = json['Vehicle_no'];
    subiid = json['Subiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iid'] = this.iid;
    data['Vehicle_no'] = this.vehicleNo;
    data['Subiid'] = this.subiid;
    return data;
  }
}