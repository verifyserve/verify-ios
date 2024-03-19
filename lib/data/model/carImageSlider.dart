class carImageSlider {
  int? id;
  String? carimg;

  carImageSlider({this.id, this.carimg});

  carImageSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carimg = json['carimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carimg'] = this.carimg;
    return data;
  }
}