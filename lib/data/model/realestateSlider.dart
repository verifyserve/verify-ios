class RealEstateSlider {
  int? id;
  String? rimg;
  int? pid;

  RealEstateSlider({this.id, this.rimg, this.pid});

  RealEstateSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rimg = json['rimg'];
    pid = json['pid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rimg'] = this.rimg;
    data['pid'] = this.pid;
    return data;
  }
}