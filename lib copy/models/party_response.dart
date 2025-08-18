class PartyResponse {
  String? message;
  List<PartyModel>? data;

  PartyResponse({this.message, this.data});

  PartyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PartyModel>[];
      json['data'].forEach((v) {
        data!.add(PartyModel.fromJson(v));
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

class PartyModel {
  String? aCCADD;
  String? aCCCD;
  String? aCCNAME;
  num? gROUPCD;
  num? oLDGROUP;
  String? bLACKLIST;
  String? cITY;
  String? sTATE;
  String? sTATECODE;
  String? pINCODE;
  String? eMAIL;
  String? wANO;
  String? sMANMOB;
  String? mobile1;
  String? lASTEDIT;
  String? pERSONNM;
  String? pERSONDESIGNATION;
  String? aDD1;
  String? aDD2;
  String? aDD3;
  String? zONE;
  num? aCCKM;
  num? oPBAL;
  num? cLBAL;
  num? dRTRANS;
  num? cRTRANS;
  String? bALANCETYPE;
  num? cREDITDAY;
  num? cRLIMIT;
  num? dEPRIPERC;
  String? oUTSTATE;
  String? tCSYN;
  String? pANNO;
  String? gSTNO;
  String? gSTTYPE;
  String? fSSAINO;
  String? rEGNO;
  num? sYNCID;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;
  String? aCCCARTITEM;

  PartyModel(
      {this.aCCADD,
        this.aCCCD,
        this.aCCNAME,
        this.gROUPCD,
        this.oLDGROUP,
        this.bLACKLIST,
        this.cITY,
        this.sTATE,
        this.sTATECODE,
        this.pINCODE,
        this.eMAIL,
        this.wANO,
        this.sMANMOB,
        this.mobile1,
        this.lASTEDIT,
        this.pERSONNM,
        this.pERSONDESIGNATION,
        this.aDD1,
        this.aDD2,
        this.aDD3,
        this.zONE,
        this.aCCKM,
        this.oPBAL,
        this.cLBAL,
        this.dRTRANS,
        this.cRTRANS,
        this.bALANCETYPE,
        this.cREDITDAY,
        this.cRLIMIT,
        this.dEPRIPERC,
        this.oUTSTATE,
        this.tCSYN,
        this.pANNO,
        this.gSTNO,
        this.gSTTYPE,
        this.fSSAINO,
        this.rEGNO,
        this.sYNCID,
        this.cREATEDBY,
        this.cREATEDAPPTYPE,
        this.uPDATEDAT,
        this.cREATEDAT,
        this.aCCCARTITEM});

  PartyModel.fromJson(Map<String, dynamic> json) {
    aCCADD = json['ACC_ADD'];
    aCCCD = json['ACC_CD'];
    aCCNAME = json['ACC_NAME'];
    gROUPCD = json['GROUP_CD'];
    oLDGROUP = json['OLD_GROUP'];
    bLACKLIST = json['BLACKLIST'];
    cITY = json['CITY'];
    sTATE = json['STATE'];
    sTATECODE = json['STATE_CODE'];
    pINCODE = json['PINCODE'];
    eMAIL = json['EMAIL'];
    wANO = json['WA_NO'];
    sMANMOB = json['SMAN_MOB'];
    mobile1 = json['Mobile1'];
    lASTEDIT = json['LAST_EDIT'];
    pERSONNM = json['PERSON_NM'];
    pERSONDESIGNATION = json['PERSON_DESIGNATION'];
    aDD1 = json['ADD1'];
    aDD2 = json['ADD2'];
    aDD3 = json['ADD3'];
    zONE = json['ZONE'];
    aCCKM = json['ACC_KM'];
    oPBAL = json['OP_BAL'];
    cLBAL = json['CL_BAL'];
    dRTRANS = json['DR_TRANS'];
    cRTRANS = json['CR_TRANS'];
    bALANCETYPE = json['BALANCE_TYPE'];
    cREDITDAY = json['CREDIT_DAY'];
    cRLIMIT = json['CR_LIMIT'];
    dEPRIPERC = json['DEPRI_PERC'];
    oUTSTATE = json['OUT_STATE'];
    tCSYN = json['TCS_YN'];
    pANNO = json['PAN_NO'];
    gSTNO = json['GST_NO'];
    gSTTYPE = json['GST_TYPE'];
    fSSAINO = json['FSSAI_NO'];
    rEGNO = json['REG_NO'];
    sYNCID = json['SYNC_ID'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
    aCCCARTITEM = json['ACC_CART_ITEM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACC_ADD'] = aCCADD;
    data['ACC_CD'] = aCCCD;
    data['ACC_NAME'] = aCCNAME;
    data['GROUP_CD'] = gROUPCD;
    data['OLD_GROUP'] = oLDGROUP;
    data['BLACKLIST'] = bLACKLIST;
    data['CITY'] = cITY;
    data['STATE'] = sTATE;
    data['STATE_CODE'] = sTATECODE;
    data['PINCODE'] = pINCODE;
    data['EMAIL'] = eMAIL;
    data['WA_NO'] = wANO;
    data['SMAN_MOB'] = sMANMOB;
    data['Mobile1'] = mobile1;
    data['LAST_EDIT'] = lASTEDIT;
    data['PERSON_NM'] = pERSONNM;
    data['PERSON_DESIGNATION'] = pERSONDESIGNATION;
    data['ADD1'] = aDD1;
    data['ADD2'] = aDD2;
    data['ADD3'] = aDD3;
    data['ZONE'] = zONE;
    data['ACC_KM'] = aCCKM;
    data['OP_BAL'] = oPBAL;
    data['CL_BAL'] = cLBAL;
    data['DR_TRANS'] = dRTRANS;
    data['CR_TRANS'] = cRTRANS;
    data['BALANCE_TYPE'] = bALANCETYPE;
    data['CREDIT_DAY'] = cREDITDAY;
    data['CR_LIMIT'] = cRLIMIT;
    data['DEPRI_PERC'] = dEPRIPERC;
    data['OUT_STATE'] = oUTSTATE;
    data['TCS_YN'] = tCSYN;
    data['PAN_NO'] = pANNO;
    data['GST_NO'] = gSTNO;
    data['GST_TYPE'] = gSTTYPE;
    data['FSSAI_NO'] = fSSAINO;
    data['REG_NO'] = rEGNO;
    data['SYNC_ID'] = sYNCID;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    data['ACC_CART_ITEM'] = aCCCARTITEM;
    return data;
  }
}
