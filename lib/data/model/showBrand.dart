class ShowBrand {
  int? id;
  String? bname;
  String? bimg;
  num? vid;

  ShowBrand({this.id, this.bname, this.bimg, this.vid});

  ShowBrand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bname = json['bname'];
    bimg = json['bimg'];
    vid = json['Vid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bname'] = this.bname;
    data['bimg'] = this.bimg;
    data['Vid'] = this.vid;
    return data;
  }
}