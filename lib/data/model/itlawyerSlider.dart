class ItLawyer_Model {
  int? id;
  String? iimage;

  ItLawyer_Model({this.id, this.iimage});

  ItLawyer_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iimage = json['iimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iimage'] = this.iimage;
    return data;
  }
}