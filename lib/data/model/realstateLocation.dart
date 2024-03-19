class realstateLocation {
  int? lid;
  String? locationh;

  realstateLocation({this.lid, this.locationh});

  realstateLocation.fromJson(Map<String, dynamic> json) {
    lid = json['lid'];
    locationh = json['locationh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lid'] = this.lid;
    data['locationh'] = this.locationh;
    return data;
  }
}