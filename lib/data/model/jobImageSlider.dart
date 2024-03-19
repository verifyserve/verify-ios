class JobsModel {
  int? id;
  String? jimage;

  JobsModel({this.id, this.jimage});

  JobsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jimage = json['Jimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Jimage'] = this.jimage;
    return data;
  }
}
