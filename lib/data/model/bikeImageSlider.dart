class BikeImageSlider {
  int? id;
  String? bikeimg;

  BikeImageSlider({this.id, this.bikeimg});

  BikeImageSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bikeimg = json['bikeimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bikeimg'] = this.bikeimg;
    return data;
  }
}