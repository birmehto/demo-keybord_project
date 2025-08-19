class TaxResponse {
  String? message;
  List<TaxModel>? data;

  TaxResponse({this.message, this.data});

  TaxResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TaxModel>[];
      json['data'].forEach((v) {
        data!.add(TaxModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxModel {
  num? cODE;
  String? nAME;
  num? sGSTRATE;
  num? cGSTRATE;
  num? iGSTRATE;
  num? rATE;
  num? oPPCODE;
  num? sYNCID;
  String? uPDATEDAT;
  String? cREATEDAT;

  TaxModel(
      {this.cODE,
      this.nAME,
      this.sGSTRATE,
      this.cGSTRATE,
      this.iGSTRATE,
      this.rATE,
      this.oPPCODE,
      this.sYNCID,
      this.uPDATEDAT,
      this.cREATEDAT});

  TaxModel.fromJson(Map<String, dynamic> json) {
    cODE = json['CODE'];
    nAME = json['NAME'];
    sGSTRATE = json['SGST_RATE'];
    cGSTRATE = json['CGST_RATE'];
    iGSTRATE = json['IGST_RATE'];
    rATE = json['RATE'];
    oPPCODE = json['OPP_CODE'];
    sYNCID = json['SYNC_ID'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CODE'] = cODE;
    data['NAME'] = nAME;
    data['SGST_RATE'] = sGSTRATE;
    data['CGST_RATE'] = cGSTRATE;
    data['IGST_RATE'] = iGSTRATE;
    data['RATE'] = rATE;
    data['OPP_CODE'] = oPPCODE;
    data['SYNC_ID'] = sYNCID;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    return data;
  }
}
