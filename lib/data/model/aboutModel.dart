class AboutPageModel {
  int? iId;
  String? aBoutus;

  AboutPageModel({this.iId, this.aBoutus});

  AboutPageModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    aBoutus = json['ABoutus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['ABoutus'] = this.aBoutus;
    return data;
  }
}