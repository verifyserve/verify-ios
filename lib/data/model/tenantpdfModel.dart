class TenantPdfModel {
  int? docsId;
  String? documentName;
  String? documentPDF;
  String? ownerNumber;
  int? tenantId;

  TenantPdfModel(
      {this.docsId,
        this.documentName,
        this.documentPDF,
        this.ownerNumber,
        this.tenantId});

  TenantPdfModel.fromJson(Map<String, dynamic> json) {
    docsId = json['Docs_id'];
    documentName = json['document_name'];
    documentPDF = json['Document_PDF'];
    ownerNumber = json['Owner_Number'];
    tenantId = json['tenant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Docs_id'] = this.docsId;
    data['document_name'] = this.documentName;
    data['Document_PDF'] = this.documentPDF;
    data['Owner_Number'] = this.ownerNumber;
    data['tenant_id'] = this.tenantId;
    return data;
  }
}