class TenantPdfModel {
  String? documentPDF;
  String? documentname;

  TenantPdfModel(
      {this.documentPDF,
      this.documentname});

  TenantPdfModel.fromJson(Map<String, dynamic> json) {
    documentPDF = json['document_pdf'];
    documentname = json['documentname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_pdf'] = this.documentPDF;
    data['documentname'] = this.documentname;
    return data;
  }
}