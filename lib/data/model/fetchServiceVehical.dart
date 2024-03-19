class FrontServiceVehical {
  int? id;
  String? vname;
  String? vimg;

  FrontServiceVehical({this.id, this.vname, this.vimg});

  FrontServiceVehical.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vname = json['vname'];
    vimg = json['vimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vname'] = this.vname;
    data['vimg'] = this.vimg;
    return data;
  }
}