class TruckList {
  int? id;
  String? loading;
  String? varified;
  String? vno;
  String? img;

  TruckList({this.id, this.loading, this.varified, this.vno, this.img});

  TruckList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loading = json['loading'];
    varified = json['varified'];
    vno = json['vno'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loading'] = this.loading;
    data['varified'] = this.varified;
    data['vno'] = this.vno;
    data['img'] = this.img;
    return data;
  }
}