class HomeSlider {
  int? id;
  String? himage;

  HomeSlider({this.id, this.himage});

  HomeSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    himage = json['Himage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Himage'] = this.himage;
    return data;
  }
}