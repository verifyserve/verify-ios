class DocumentMainModel {
  int? id;
  String? dimage;

  DocumentMainModel({this.id, this.dimage});

  DocumentMainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dimage = json['Dimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Dimage'] = this.dimage;
    return data;
  }
}