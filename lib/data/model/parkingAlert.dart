class ParkingAlerts {
  int? id;
  String? carNo;

  ParkingAlerts({this.id, this.carNo});

  ParkingAlerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carNo = json['car_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_no'] = this.carNo;
    return data;
  }
}