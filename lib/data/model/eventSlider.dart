class EventModel {
  int? id;
  String? eimage;

  EventModel({this.id, this.eimage});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eimage = json['Eimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Eimage'] = this.eimage;
    return data;
  }
}