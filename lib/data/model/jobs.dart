class Jobs {
  int? id;
  String? jname;
  String? jimg;

  Jobs({this.id, this.jname, this.jimg});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    jname = json["jname"];
    jimg = json["jimg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["jname"] = jname;
    _data["jimg"] = jimg;
    return _data;
  }
}