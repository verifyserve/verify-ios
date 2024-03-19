class HotelImageSlider {
  int? id;
  String? img;

  HotelImageSlider({this.id, this.img});

  HotelImageSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    return data;
  }
}