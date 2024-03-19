class ShowEmployeeType {
  int? tPid;
  String? ename;
  String? pname;
  int? subid;

  ShowEmployeeType({this.tPid, this.ename, this.subid,this.pname});

  ShowEmployeeType.fromJson(Map<String, dynamic> json) {
    tPid = json['TPid'];
    ename = json['Ename'];
    pname = json['TPname'];
    subid = json['Subid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TPid'] = this.tPid;
    data['Ename'] = this.ename;
    data['TPname'] = this.pname;
    data['Subid'] = this.subid;
    return data;
  }
}