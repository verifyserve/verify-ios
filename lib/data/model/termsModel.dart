class PrivacyTermsModel {
  int? iId;
  String? termsandconditions;

  PrivacyTermsModel({this.iId, this.termsandconditions});

  PrivacyTermsModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    termsandconditions = json['termsandconditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['termsandconditions'] = this.termsandconditions;
    return data;
  }
}