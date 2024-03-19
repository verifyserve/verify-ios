class PrivacyPageModel {
  int? iId;
  String? privacypolicy;

  PrivacyPageModel({this.iId, this.privacypolicy});

  PrivacyPageModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    privacypolicy = json['privacypolicy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['privacypolicy'] = this.privacypolicy;
    return data;
  }
}