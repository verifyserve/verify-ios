class MainPdfModel {
  int? iidd;
  String? viimg;

  MainPdfModel({this.iidd, this.viimg});

  MainPdfModel.fromJson(Map<String, dynamic> json) {
    iidd = json['iidd'];
    viimg = json['Viimg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iidd'] = this.iidd;
    data['Viimg'] = this.viimg;
    return data;
  }
}