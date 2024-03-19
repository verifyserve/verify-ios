class HomePageGrid {
  int? vid;
  String? vname;
  String? vimage;

  HomePageGrid({this.vid, this.vname, this.vimage});

  HomePageGrid.fromJson(Map<String, dynamic> json) {
    vid = json['Vid'];
    vname = json['Vname'];
    vimage = json['Vimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Vid'] = this.vid;
    data['Vname'] = this.vname;
    data['Vimage'] = this.vimage;
    return data;
  }
}