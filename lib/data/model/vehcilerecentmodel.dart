class VechicleRecentModel {
  int? id;
  String? senderName;
  String? date;
  String? time;
  int? userid;
  String? reciverName;
  int? sid;

  VechicleRecentModel(
      {this.id,
        this.senderName,
        this.date,
        this.time,
        this.userid,
        this.reciverName,
        this.sid});

  VechicleRecentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderName = json['sender_name'];
    date = json['date'];
    time = json['time'];
    userid = json['userid'];
    reciverName = json['reciver_name'];
    sid = json['sid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_name'] = this.senderName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['userid'] = this.userid;
    data['reciver_name'] = this.reciverName;
    data['sid'] = this.sid;
    return data;
  }
}