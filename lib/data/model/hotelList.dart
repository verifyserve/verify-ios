class HotelList {
  int? id;
  String? hname;
  String? location;
  String? price;
  String? img;

  HotelList({this.id, this.hname, this.location, this.price, this.img});

  HotelList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hname = json['hname'];
    location = json['location'];
    price = json['price'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hname'] = this.hname;
    data['location'] = this.location;
    data['price'] = this.price;
    data['img'] = this.img;
    return data;
  }
}