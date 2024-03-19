class ItDesign {
  int? id;
  String? iname;
  String? iimg;

  ItDesign({this.id, this.iname, this.iimg});

  ItDesign.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    iname = json["iname"];
    iimg = json["iimg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["iname"] = iname;
    _data["iimg"] = iimg;
    return _data;
  }
}