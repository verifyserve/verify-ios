class ConsultantAndLawyer {
  int? aid;
  String? aname;
  String? aimage;

  ConsultantAndLawyer({this.aid, this.aname, this.aimage});

  ConsultantAndLawyer.fromJson(Map<String, dynamic> json) {
    aid = json['Aid'];
    aname = json['Aname'];
    aimage = json['Aimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Aid'] = this.aid;
    data['Aname'] = this.aname;
    data['Aimage'] = this.aimage;
    return data;
  }
}