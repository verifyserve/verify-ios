class Service {
  int? id;
  String? scname;
  String? scimg;

  Service({this.id, this.scname, this.scimg});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scname = json['scname'];
    scimg = json['scimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scname'] = this.scname;
    data['scimg'] = this.scimg;
    return data;
  }
}