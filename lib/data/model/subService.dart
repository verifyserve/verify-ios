class SubService {
  int? id;
  String? title;
  String? experience;
  String? address;
  String? subimg;
  String? filterlocation;
  int? scid;

  SubService(
      {this.id,
        this.title,
        this.experience,
        this.address,
        this.subimg,
        this.filterlocation,
        this.scid});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    experience = json['experience'];
    address = json['address'];
    subimg = json['subimg'];
    filterlocation = json['Filterlocation'];
    scid = json['Scid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['experience'] = this.experience;
    data['address'] = this.address;
    data['subimg'] = this.subimg;
    data['Filterlocation'] = this.filterlocation;
    data['Scid'] = this.scid;
    return data;
  }
}