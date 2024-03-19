class YourInfo {
  int? dPid;
  String? addharcard;
  String? policeVerificatuion;
  String? rentAggrement;
  String? subidd;

  YourInfo(
      {this.dPid,
        this.addharcard,
        this.policeVerificatuion,
        this.rentAggrement,
        this.subidd});

  YourInfo.fromJson(Map<String, dynamic> json) {
    dPid = json['DPid'];
    addharcard = json['Addharcard'];
    policeVerificatuion = json['PoliceVerificatuion'];
    rentAggrement = json['Rent_aggrement'];
    subidd = json['subidd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DPid'] = this.dPid;
    data['Addharcard'] = this.addharcard;
    data['PoliceVerificatuion'] = this.policeVerificatuion;
    data['Rent_aggrement'] = this.rentAggrement;
    data['subidd'] = this.subidd;
    return data;
  }
}