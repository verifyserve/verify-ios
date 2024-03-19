class DocumentTenantDetailsModel {
  int? id;
  String? timage;
  int? tid;

  DocumentTenantDetailsModel({this.id, this.timage, this.tid});

  DocumentTenantDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timage = json['Timage'];
    tid = json['Tid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Timage'] = this.timage;
    data['Tid'] = this.tid;
    return data;
  }
}