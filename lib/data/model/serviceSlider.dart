class ServiceModel {
  int? id;
  String? simage;

  ServiceModel({this.id, this.simage});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    simage = json['Simage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Simage'] = this.simage;
    return data;
  }
}