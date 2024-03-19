class RealStateHorizontalCategory {
  int? rRid;
  String? rRname;

  RealStateHorizontalCategory({this.rRid, this.rRname});

  RealStateHorizontalCategory.fromJson(Map<String, dynamic> json) {
    rRid = json['RRid'];
    rRname = json['RRname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RRid'] = this.rRid;
    data['RRname'] = this.rRname;
    return data;
  }
}