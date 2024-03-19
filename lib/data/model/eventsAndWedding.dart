class EventsAndWedding {
  int? id;
  String? ename;
  String? eimg;

  EventsAndWedding({this.id, this.ename, this.eimg});

  EventsAndWedding.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    ename = json["ename"];
    eimg = json["eimg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["ename"] = ename;
    _data["eimg"] = eimg;
    return _data;
  }
}