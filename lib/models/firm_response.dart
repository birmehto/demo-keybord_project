class FirmResponse {
  String? message;
  List<FirmModel>? data;

  FirmResponse({this.message, this.data});

  FirmResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <FirmModel>[];
      json['data'].forEach((v) {
        data!.add(FirmModel.fromJson(v));
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

class FirmModel {
  String? fIRMQRCODE;
  String? fIRMLOGO;
  String? fIRMSIGN;
  String? fIRMID;
  String? cUSTID;
  int? sYNCID;
  String? fIRMNAME;
  String? aDD1;
  String? aDD2;
  String? aDD3;
  String? aDD4;
  String? aDD5;
  String? cITY;
  String? sTATE;
  String? sTATECODE;
  String? zONE;
  String? pINCODE;
  String? mOBILE1;
  String? mOBILE2;
  String? pERSONNM;
  String? eMAILID;
  String? uPI;
  String? gSTNO;
  String? gSTTYPE;
  String? pANNO;
  String? fSSAINO;
  String? rEGNO1;
  String? rEGNO2;
  String? tCSWITHPAN;
  String? tCSWITHOUTPAN;
  String? tCSAUTO;
  String? tCSABOVE;
  bool? iSLOCKED;
  String? fOOTER1;
  String? fOOTER2;
  String? fOOTER3;
  String? fOOTER4;
  String? fOOTER5;
  String? dRUGLIC1;
  String? dRUGLIC2;
  String? dRUGLIC3;
  String? dRUGLIC4;
  String? dRUGDATE1;
  String? dRUGDATE2;
  String? dRUGDATE3;
  String? dRUGDATE4;

  FirmModel({
    this.fIRMQRCODE,
    this.fIRMLOGO,
    this.fIRMSIGN,
    this.fIRMID,
    this.cUSTID,
    this.sYNCID,
    this.fIRMNAME,
    this.aDD1,
    this.aDD2,
    this.aDD3,
    this.aDD4,
    this.aDD5,
    this.cITY,
    this.sTATE,
    this.sTATECODE,
    this.zONE,
    this.pINCODE,
    this.mOBILE1,
    this.mOBILE2,
    this.pERSONNM,
    this.eMAILID,
    this.uPI,
    this.gSTNO,
    this.gSTTYPE,
    this.pANNO,
    this.fSSAINO,
    this.rEGNO1,
    this.rEGNO2,
    this.tCSWITHPAN,
    this.tCSWITHOUTPAN,
    this.tCSAUTO,
    this.tCSABOVE,
    this.iSLOCKED,
    this.fOOTER1,
    this.fOOTER2,
    this.fOOTER3,
    this.fOOTER4,
    this.fOOTER5,
    this.dRUGLIC1,
    this.dRUGLIC2,
    this.dRUGLIC3,
    this.dRUGLIC4,
    this.dRUGDATE1,
    this.dRUGDATE2,
    this.dRUGDATE3,
    this.dRUGDATE4,
  });

  FirmModel.fromJson(Map<String, dynamic> json) {
    fIRMQRCODE = json['FIRM_QR_CODE'];
    fIRMLOGO = json['FIRM_LOGO'];
    fIRMSIGN = json['FIRM_SIGN'];
    fIRMID = json['FIRM_ID'];
    cUSTID = json['CUST_ID'];
    sYNCID = json['SYNC_ID'];
    fIRMNAME = json['FIRM_NAME'];
    aDD1 = json['ADD1'];
    aDD2 = json['ADD2'];
    aDD3 = json['ADD3'];
    aDD4 = json['ADD4'];
    aDD5 = json['ADD5'];
    cITY = json['CITY'];
    sTATE = json['STATE'];
    sTATECODE = json['STATE_CODE'];
    zONE = json['ZONE'];
    pINCODE = json['PINCODE'];
    mOBILE1 = json['MOBILE1'];
    mOBILE2 = json['MOBILE2'];
    pERSONNM = json['PERSON_NM'];
    eMAILID = json['EMAIL_ID'];
    uPI = json['UPI'];
    gSTNO = json['GST_NO'];
    gSTTYPE = json['GST_TYPE'];
    pANNO = json['PAN_NO'];
    fSSAINO = json['FSSAI_NO'];
    rEGNO1 = json['REG_NO_1'];
    rEGNO2 = json['REG_NO_2'];
    tCSWITHPAN = json['TCS_WITH_PAN'];
    tCSWITHOUTPAN = json['TCS_WITHOUT_PAN'];
    tCSAUTO = json['TCS_AUTO'];
    tCSABOVE = json['TCS_ABOVE'];
    iSLOCKED = json['IS_LOCKED'];
    fOOTER1 = json['FOOTER1'];
    fOOTER2 = json['FOOTER2'];
    fOOTER3 = json['FOOTER3'];
    fOOTER4 = json['FOOTER4'];
    fOOTER5 = json['FOOTER5'];
    dRUGLIC1 = json['DRUG_LIC1'];
    dRUGLIC2 = json['DRUG_LIC2'];
    dRUGLIC3 = json['DRUG_LIC3'];
    dRUGLIC4 = json['DRUG_LIC4'];
    dRUGDATE1 = json['DRUG_DATE1'];
    dRUGDATE2 = json['DRUG_DATE2'];
    dRUGDATE3 = json['DRUG_DATE3'];
    dRUGDATE4 = json['DRUG_DATE4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FIRM_QR_CODE'] = fIRMQRCODE;
    data['FIRM_LOGO'] = fIRMLOGO;
    data['FIRM_SIGN'] = fIRMSIGN;
    data['FIRM_ID'] = fIRMID;
    data['CUST_ID'] = cUSTID;
    data['SYNC_ID'] = sYNCID;
    data['FIRM_NAME'] = fIRMNAME;
    data['ADD1'] = aDD1;
    data['ADD2'] = aDD2;
    data['ADD3'] = aDD3;
    data['ADD4'] = aDD4;
    data['ADD5'] = aDD5;
    data['CITY'] = cITY;
    data['STATE'] = sTATE;
    data['STATE_CODE'] = sTATECODE;
    data['ZONE'] = zONE;
    data['PINCODE'] = pINCODE;
    data['MOBILE1'] = mOBILE1;
    data['MOBILE2'] = mOBILE2;
    data['PERSON_NM'] = pERSONNM;
    data['EMAIL_ID'] = eMAILID;
    data['UPI'] = uPI;
    data['GST_NO'] = gSTNO;
    data['GST_TYPE'] = gSTTYPE;
    data['PAN_NO'] = pANNO;
    data['FSSAI_NO'] = fSSAINO;
    data['REG_NO_1'] = rEGNO1;
    data['REG_NO_2'] = rEGNO2;
    data['TCS_WITH_PAN'] = tCSWITHPAN;
    data['TCS_WITHOUT_PAN'] = tCSWITHOUTPAN;
    data['TCS_AUTO'] = tCSAUTO;
    data['TCS_ABOVE'] = tCSABOVE;
    data['IS_LOCKED'] = iSLOCKED;
    data['FOOTER1'] = fOOTER1;
    data['FOOTER2'] = fOOTER2;
    data['FOOTER3'] = fOOTER3;
    data['FOOTER4'] = fOOTER4;
    data['FOOTER5'] = fOOTER5;
    data['DRUG_LIC1'] = dRUGLIC1;
    data['DRUG_LIC2'] = dRUGLIC2;
    data['DRUG_LIC3'] = dRUGLIC3;
    data['DRUG_LIC4'] = dRUGLIC4;
    data['DRUG_DATE1'] = dRUGDATE1;
    data['DRUG_DATE2'] = dRUGDATE2;
    data['DRUG_DATE3'] = dRUGDATE3;
    data['DRUG_DATE4'] = dRUGDATE4;
    return data;
  }
}
