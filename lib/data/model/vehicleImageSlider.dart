class VehicleSlider {
  int? id;
  String? vimage;

  VehicleSlider({this.id, this.vimage});

  VehicleSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vimage = json['Vimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Vimage'] = this.vimage;
    return data;
  }
}