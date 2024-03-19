class DocumentationHorizontalCategory {
  int? tid;
  String? stCname;

  DocumentationHorizontalCategory({this.tid, this.stCname});

  DocumentationHorizontalCategory.fromJson(Map<String, dynamic> json) {
    tid = json['Tid'];
    stCname = json['TCname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Tid'] = this.tid;
    data['TCname'] = this.stCname;
    return data;
  }
}