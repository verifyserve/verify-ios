class CalenderEventModel {
  int? nid;
  String? nname;
  String? nDate;
  String? nTime;
  String? nDes;
  String? nLocation;
  String? nNumber;
  String? ntype;

  CalenderEventModel(
      {this.nid,
        this.nname,
        this.nDate,
        this.nTime,
        this.nDes,
        this.nLocation,
        this.nNumber,
        this.ntype});

  CalenderEventModel.fromJson(Map<String, dynamic> json) {
    nid = json['Nid'];
    nname = json['Nname'];
    nDate = json['NDate'];
    nTime = json['NTime'];
    nDes = json['NDes'];
    nLocation = json['NLocation'];
    nNumber = json['NNumber'];
    ntype = json['Ntype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nid'] = this.nid;
    data['Nname'] = this.nname;
    data['NDate'] = this.nDate;
    data['NTime'] = this.nTime;
    data['NDes'] = this.nDes;
    data['NLocation'] = this.nLocation;
    data['NNumber'] = this.nNumber;
    data['Ntype'] = this.ntype;
    return data;
  }
}