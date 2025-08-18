class SalesExpandResponse {
  SalesExpandModel? sales;
  List<SalesExpandItemsModel>? items;

  SalesExpandResponse({this.sales, this.items});

  SalesExpandResponse.fromJson(Map<String, dynamic> json) {
    sales =
        json['sales'] != null ? SalesExpandModel.fromJson(json['sales']) : null;
    if (json['items'] != null) {
      items = <SalesExpandItemsModel>[];
      json['items'].forEach((v) {
        items!.add(SalesExpandItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sales != null) {
      data['sales'] = sales!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesExpandModel {
  String? vOUCHDT;
  int? sALESID;
  String? vOUCHTIME;
  int? vOUCHNO;
  String? bNOSERIES;
  String? bILLNO;
  String? bOOKCD;
  String? cHLNNO;
  String? eINVACK;
  String? eINVIRN;
  String? eWAYNO;
  String? oRDERNO;
  String? sALESCD;
  String? pARTYCD;
  String? sHIPPARTY;
  String? pAYMODE;
  String? cASHCD;
  String? cASHAMT;
  String? cASHRECV;
  String? bANKCD;
  String? bANKAMT;
  String? cARDCD;
  String? cARDAMT;
  String? cREDITAMT;
  String? uPICD;
  String? uPIAMT;
  String? iTEMDISC;
  String? iTEMCHRG;
  String? gROSSAMT;
  String? iTEMAMT;
  String? dISCPER1;
  String? dISCAMT1;
  String? dISCACC1;
  String? dISCPERC2;
  String? dISCAMT2;
  String? dISCACC2;
  String? dISCPERC3;
  String? dISCAMT3;
  String? dISCACC3;
  String? dISCPERC4;
  String? dISCAMT4;
  String? dISCACC4;
  String? dISCPERC5;
  String? dISCAMT5;
  String? dISCACC5;
  String? cHRGPER1;
  String? cHRGAMT1;
  String? cHRGACC1;
  String? cHRGPER2;
  String? cHRGAMT2;
  String? cHRGACC2;
  String? cHRGPER3;
  String? cHRGAMT3;
  String? cHRGACC3;
  String? cHRGPER4;
  String? cHRGAMT4;
  String? cHRGACC4;
  String? cHRGPER5;
  String? cHRGAMT5;
  String? cHRGACC5;
  String? rOUNDOFF;
  String? rOUNDACC;
  String? nETAMT;
  String? nARRATION;
  String? nARRATION1;
  String? iMGFILE1;
  int? nOOFITEM;
  String? qTYTOTAL;
  String? dESCTOTAL;
  String? sMANCD;
  String? dMANCD;
  int? cRDAYS;
  int? pRTDCOPY;
  String? pAIDTBP;
  String? sGSTACC;
  String? sGSTAMT;
  String? cGSTACC;
  String? cGSTAMT;
  String? iGSTACC;
  String? iGSTAMT;
  String? gCESSAMT;
  String? gCESSACC;
  String? tCSTDS;
  String? tCSPERC;
  String? tCSAMT;
  String? pARCLE;
  String? lRNO;
  String? lRDATE;
  String? tRANSPORT;
  String? fRIEGHT;
  String? sERVTAX;
  String? pAYTOPAY;
  String? dESTI;
  String? lOADADD;
  String? lOADCITY;
  String? lOADPIN;
  String? uLOADADD;
  String? uLOADCITY;
  String? uLOADPIN;
  String? aDVANCEAMT;
  String? tRUCKNO;
  String? dRIVERNM;
  String? dRIVERLIC;
  String? dRIVERMOB;
  String? oWNERNM;
  String? hOLDNO;
  String? cOURIERDOCNO;
  String? tRANSACC;
  String? kM;
  String? cHEQUENO;
  String? uPITRANSACTIONNO;
  String? cARDTRANSACTIONNO;
  String? cARDNO;
  int? sYNCID;
  String? uPDATEDAT;
  String? cREATEDAT;
  String? dELETEDAT;
  String? cREATEDBY;
  String? uPDATEDBY;
  String? dELETEDBY;
  String? cREATEDAPPTYPE;

  //bool? iSDELETED;
  Account? account;

  SalesExpandModel(
      {this.vOUCHDT,
      this.sALESID,
      this.vOUCHTIME,
      this.vOUCHNO,
      this.bNOSERIES,
      this.bILLNO,
      this.bOOKCD,
      this.cHLNNO,
      this.eINVACK,
      this.eINVIRN,
      this.eWAYNO,
      this.oRDERNO,
      this.sALESCD,
      this.pARTYCD,
      this.sHIPPARTY,
      this.pAYMODE,
      this.cASHCD,
      this.cASHAMT,
      this.cASHRECV,
      this.bANKCD,
      this.bANKAMT,
      this.cARDCD,
      this.cARDAMT,
      this.cREDITAMT,
      this.uPICD,
      this.uPIAMT,
      this.iTEMDISC,
      this.iTEMCHRG,
      this.gROSSAMT,
      this.iTEMAMT,
      this.dISCPER1,
      this.dISCAMT1,
      this.dISCACC1,
      this.dISCPERC2,
      this.dISCAMT2,
      this.dISCACC2,
      this.dISCPERC3,
      this.dISCAMT3,
      this.dISCACC3,
      this.dISCPERC4,
      this.dISCAMT4,
      this.dISCACC4,
      this.dISCPERC5,
      this.dISCAMT5,
      this.dISCACC5,
      this.cHRGPER1,
      this.cHRGAMT1,
      this.cHRGACC1,
      this.cHRGPER2,
      this.cHRGAMT2,
      this.cHRGACC2,
      this.cHRGPER3,
      this.cHRGAMT3,
      this.cHRGACC3,
      this.cHRGPER4,
      this.cHRGAMT4,
      this.cHRGACC4,
      this.cHRGPER5,
      this.cHRGAMT5,
      this.cHRGACC5,
      this.rOUNDOFF,
      this.rOUNDACC,
      this.nETAMT,
      this.nARRATION,
      this.nARRATION1,
      this.iMGFILE1,
      this.nOOFITEM,
      this.qTYTOTAL,
      this.dESCTOTAL,
      this.sMANCD,
      this.dMANCD,
      this.cRDAYS,
      this.pRTDCOPY,
      this.pAIDTBP,
      this.sGSTACC,
      this.sGSTAMT,
      this.cGSTACC,
      this.cGSTAMT,
      this.iGSTACC,
      this.iGSTAMT,
      this.gCESSAMT,
      this.gCESSACC,
      this.tCSTDS,
      this.tCSPERC,
      this.tCSAMT,
      this.pARCLE,
      this.lRNO,
      this.lRDATE,
      this.tRANSPORT,
      this.fRIEGHT,
      this.sERVTAX,
      this.pAYTOPAY,
      this.dESTI,
      this.lOADADD,
      this.lOADCITY,
      this.lOADPIN,
      this.uLOADADD,
      this.uLOADCITY,
      this.uLOADPIN,
      this.aDVANCEAMT,
      this.tRUCKNO,
      this.dRIVERNM,
      this.dRIVERLIC,
      this.dRIVERMOB,
      this.oWNERNM,
      this.hOLDNO,
      this.cOURIERDOCNO,
      this.tRANSACC,
      this.kM,
      this.cHEQUENO,
      this.uPITRANSACTIONNO,
      this.cARDTRANSACTIONNO,
      this.cARDNO,
      this.sYNCID,
      this.uPDATEDAT,
      this.cREATEDAT,
      this.dELETEDAT,
      this.cREATEDBY,
      this.uPDATEDBY,
      this.dELETEDBY,
      this.cREATEDAPPTYPE,
      //this.iSDELETED,
      this.account});

  SalesExpandModel.fromJson(Map<String, dynamic> json) {
    vOUCHDT = json['VOUCH_DT'];
    sALESID = json['SALES_ID'];
    vOUCHTIME = json['VOUCH_TIME'];
    vOUCHNO = json['VOUCH_NO'];
    bNOSERIES = json['BNO_SERIES'];
    bILLNO = json['BILLNO'];
    bOOKCD = json['BOOK_CD'];
    cHLNNO = json['CHLN_NO'];
    eINVACK = json['EINV_ACK'];
    eINVIRN = json['EINV_IRN'];
    eWAYNO = json['EWAY_NO'];
    oRDERNO = json['ORDER_NO'];
    sALESCD = json['SALES_CD'];
    pARTYCD = json['PARTY_CD'];
    sHIPPARTY = json['SHIP_PARTY'];
    pAYMODE = json['PAY_MODE'];
    cASHCD = json['CASH_CD'];
    cASHAMT = json['CASH_AMT'];
    cASHRECV = json['CASH_RECV'];
    bANKCD = json['BANK_CD'];
    bANKAMT = json['BANK_AMT'];
    cARDCD = json['CARD_CD'];
    cARDAMT = json['CARD_AMT'];
    cREDITAMT = json['CREDIT_AMT'];
    uPICD = json['UPI_CD'];
    uPIAMT = json['UPI_AMT'];
    iTEMDISC = json['ITEM_DISC'];
    iTEMCHRG = json['ITEM_CHRG'];
    gROSSAMT = json['GROSS_AMT'];
    iTEMAMT = json['ITEM_AMT'];
    dISCPER1 = json['DISC_PER1'];
    dISCAMT1 = json['DISC_AMT1'];
    dISCACC1 = json['DISC_ACC1'];
    dISCPERC2 = json['DISC_PERC2'];
    dISCAMT2 = json['DISC_AMT2'];
    dISCACC2 = json['DISC_ACC2'];
    dISCPERC3 = json['DISC_PERC3'];
    dISCAMT3 = json['DISC_AMT3'];
    dISCACC3 = json['DISC_ACC3'];
    dISCPERC4 = json['DISC_PERC4'];
    dISCAMT4 = json['DISC_AMT4'];
    dISCACC4 = json['DISC_ACC4'];
    dISCPERC5 = json['DISC_PERC5'];
    dISCAMT5 = json['DISC_AMT5'];
    dISCACC5 = json['DISC_ACC5'];
    cHRGPER1 = json['CHRG_PER1'];
    cHRGAMT1 = json['CHRG_AMT1'];
    cHRGACC1 = json['CHRG_ACC1'];
    cHRGPER2 = json['CHRG_PER2'];
    cHRGAMT2 = json['CHRG_AMT2'];
    cHRGACC2 = json['CHRG_ACC2'];
    cHRGPER3 = json['CHRG_PER3'];
    cHRGAMT3 = json['CHRG_AMT3'];
    cHRGACC3 = json['CHRG_ACC3'];
    cHRGPER4 = json['CHRG_PER4'];
    cHRGAMT4 = json['CHRG_AMT4'];
    cHRGACC4 = json['CHRG_ACC4'];
    cHRGPER5 = json['CHRG_PER5'];
    cHRGAMT5 = json['CHRG_AMT5'];
    cHRGACC5 = json['CHRG_ACC5'];
    rOUNDOFF = json['ROUND_OFF'];
    rOUNDACC = json['ROUND_ACC'];
    nETAMT = json['NET_AMT'];
    nARRATION = json['NARRATION'];
    nARRATION1 = json['NARRATION1'];
    iMGFILE1 = json['IMG_FILE1'];
    nOOFITEM = json['NO_OF_ITEM'];
    qTYTOTAL = json['QTY_TOTAL'];
    dESCTOTAL = json['DESC_TOTAL'];
    sMANCD = json['SMAN_CD'];
    dMANCD = json['DMAN_CD'];
    cRDAYS = json['CR_DAYS'];
    pRTDCOPY = json['PRTD_COPY'];
    pAIDTBP = json['PAID_TBP'];
    sGSTACC = json['SGST_ACC'];
    sGSTAMT = json['SGST_AMT'];
    cGSTACC = json['CGST_ACC'];
    cGSTAMT = json['CGST_AMT'];
    iGSTACC = json['IGST_ACC'];
    iGSTAMT = json['IGST_AMT'];
    gCESSAMT = json['GCESS_AMT'];
    gCESSACC = json['GCESS_ACC'];
    tCSTDS = json['TCS_TDS'];
    tCSPERC = json['TCS_PERC'];
    tCSAMT = json['TCS_AMT'];
    pARCLE = json['PARCLE'];
    lRNO = json['LR_NO'];
    lRDATE = json['LR_DATE'];
    tRANSPORT = json['TRANSPORT'];
    fRIEGHT = json['FRIEGHT'];
    sERVTAX = json['SERV_TAX'];
    pAYTOPAY = json['PAY_TOPAY'];
    dESTI = json['DESTI'];
    lOADADD = json['LOAD_ADD'];
    lOADCITY = json['LOAD_CITY'];
    lOADPIN = json['LOAD_PIN'];
    uLOADADD = json['ULOAD_ADD'];
    uLOADCITY = json['ULOAD_CITY'];
    uLOADPIN = json['ULOAD_PIN'];
    aDVANCEAMT = json['ADVANCE_AMT'];
    tRUCKNO = json['TRUCK_NO'];
    dRIVERNM = json['DRIVER_NM'];
    dRIVERLIC = json['DRIVER_LIC'];
    dRIVERMOB = json['DRIVER_MOB'];
    oWNERNM = json['OWNER_NM'];
    hOLDNO = json['HOLD_NO'];
    cOURIERDOCNO = json['COURIER_DOC_NO'];
    tRANSACC = json['TRANS_ACC'];
    kM = json['KM'];
    cHEQUENO = json['CHEQUE_NO'];
    uPITRANSACTIONNO = json['UPI_TRANSACTION_NO'];
    cARDTRANSACTIONNO = json['CARD_TRANSACTION_NO'];
    cARDNO = json['CARD_NO'];
    sYNCID = json['SYNC_ID'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
    dELETEDAT = json['DELETED_AT'];
    cREATEDBY = json['CREATED_BY'];
    uPDATEDBY = json['UPDATED_BY'];
    dELETEDBY = json['DELETED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    //iSDELETED = json['ISDELETED'];
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VOUCH_DT'] = vOUCHDT;
    data['SALES_ID'] = sALESID;
    data['VOUCH_TIME'] = vOUCHTIME;
    data['VOUCH_NO'] = vOUCHNO;
    data['BNO_SERIES'] = bNOSERIES;
    data['BILLNO'] = bILLNO;
    data['BOOK_CD'] = bOOKCD;
    data['CHLN_NO'] = cHLNNO;
    data['EINV_ACK'] = eINVACK;
    data['EINV_IRN'] = eINVIRN;
    data['EWAY_NO'] = eWAYNO;
    data['ORDER_NO'] = oRDERNO;
    data['SALES_CD'] = sALESCD;
    data['PARTY_CD'] = pARTYCD;
    data['SHIP_PARTY'] = sHIPPARTY;
    data['PAY_MODE'] = pAYMODE;
    data['CASH_CD'] = cASHCD;
    data['CASH_AMT'] = cASHAMT;
    data['CASH_RECV'] = cASHRECV;
    data['BANK_CD'] = bANKCD;
    data['BANK_AMT'] = bANKAMT;
    data['CARD_CD'] = cARDCD;
    data['CARD_AMT'] = cARDAMT;
    data['CREDIT_AMT'] = cREDITAMT;
    data['UPI_CD'] = uPICD;
    data['UPI_AMT'] = uPIAMT;
    data['ITEM_DISC'] = iTEMDISC;
    data['ITEM_CHRG'] = iTEMCHRG;
    data['GROSS_AMT'] = gROSSAMT;
    data['ITEM_AMT'] = iTEMAMT;
    data['DISC_PER1'] = dISCPER1;
    data['DISC_AMT1'] = dISCAMT1;
    data['DISC_ACC1'] = dISCACC1;
    data['DISC_PERC2'] = dISCPERC2;
    data['DISC_AMT2'] = dISCAMT2;
    data['DISC_ACC2'] = dISCACC2;
    data['DISC_PERC3'] = dISCPERC3;
    data['DISC_AMT3'] = dISCAMT3;
    data['DISC_ACC3'] = dISCACC3;
    data['DISC_PERC4'] = dISCPERC4;
    data['DISC_AMT4'] = dISCAMT4;
    data['DISC_ACC4'] = dISCACC4;
    data['DISC_PERC5'] = dISCPERC5;
    data['DISC_AMT5'] = dISCAMT5;
    data['DISC_ACC5'] = dISCACC5;
    data['CHRG_PER1'] = cHRGPER1;
    data['CHRG_AMT1'] = cHRGAMT1;
    data['CHRG_ACC1'] = cHRGACC1;
    data['CHRG_PER2'] = cHRGPER2;
    data['CHRG_AMT2'] = cHRGAMT2;
    data['CHRG_ACC2'] = cHRGACC2;
    data['CHRG_PER3'] = cHRGPER3;
    data['CHRG_AMT3'] = cHRGAMT3;
    data['CHRG_ACC3'] = cHRGACC3;
    data['CHRG_PER4'] = cHRGPER4;
    data['CHRG_AMT4'] = cHRGAMT4;
    data['CHRG_ACC4'] = cHRGACC4;
    data['CHRG_PER5'] = cHRGPER5;
    data['CHRG_AMT5'] = cHRGAMT5;
    data['CHRG_ACC5'] = cHRGACC5;
    data['ROUND_OFF'] = rOUNDOFF;
    data['ROUND_ACC'] = rOUNDACC;
    data['NET_AMT'] = nETAMT;
    data['NARRATION'] = nARRATION;
    data['NARRATION1'] = nARRATION1;
    data['IMG_FILE1'] = iMGFILE1;
    data['NO_OF_ITEM'] = nOOFITEM;
    data['QTY_TOTAL'] = qTYTOTAL;
    data['DESC_TOTAL'] = dESCTOTAL;
    data['SMAN_CD'] = sMANCD;
    data['DMAN_CD'] = dMANCD;
    data['CR_DAYS'] = cRDAYS;
    data['PRTD_COPY'] = pRTDCOPY;
    data['PAID_TBP'] = pAIDTBP;
    data['SGST_ACC'] = sGSTACC;
    data['SGST_AMT'] = sGSTAMT;
    data['CGST_ACC'] = cGSTACC;
    data['CGST_AMT'] = cGSTAMT;
    data['IGST_ACC'] = iGSTACC;
    data['IGST_AMT'] = iGSTAMT;
    data['GCESS_AMT'] = gCESSAMT;
    data['GCESS_ACC'] = gCESSACC;
    data['TCS_TDS'] = tCSTDS;
    data['TCS_PERC'] = tCSPERC;
    data['TCS_AMT'] = tCSAMT;
    data['PARCLE'] = pARCLE;
    data['LR_NO'] = lRNO;
    data['LR_DATE'] = lRDATE;
    data['TRANSPORT'] = tRANSPORT;
    data['FRIEGHT'] = fRIEGHT;
    data['SERV_TAX'] = sERVTAX;
    data['PAY_TOPAY'] = pAYTOPAY;
    data['DESTI'] = dESTI;
    data['LOAD_ADD'] = lOADADD;
    data['LOAD_CITY'] = lOADCITY;
    data['LOAD_PIN'] = lOADPIN;
    data['ULOAD_ADD'] = uLOADADD;
    data['ULOAD_CITY'] = uLOADCITY;
    data['ULOAD_PIN'] = uLOADPIN;
    data['ADVANCE_AMT'] = aDVANCEAMT;
    data['TRUCK_NO'] = tRUCKNO;
    data['DRIVER_NM'] = dRIVERNM;
    data['DRIVER_LIC'] = dRIVERLIC;
    data['DRIVER_MOB'] = dRIVERMOB;
    data['OWNER_NM'] = oWNERNM;
    data['HOLD_NO'] = hOLDNO;
    data['COURIER_DOC_NO'] = cOURIERDOCNO;
    data['TRANS_ACC'] = tRANSACC;
    data['KM'] = kM;
    data['CHEQUE_NO'] = cHEQUENO;
    data['UPI_TRANSACTION_NO'] = uPITRANSACTIONNO;
    data['CARD_TRANSACTION_NO'] = cARDTRANSACTIONNO;
    data['CARD_NO'] = cARDNO;
    data['SYNC_ID'] = sYNCID;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    data['DELETED_AT'] = dELETEDAT;
    data['CREATED_BY'] = cREATEDBY;
    data['UPDATED_BY'] = uPDATEDBY;
    data['DELETED_BY'] = dELETEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    //data['ISDELETED'] = iSDELETED;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

class Account {
  String? aCCCD;
  String? aCCNAME;
  String? pERSONNM;
  String? aDD1;
  String? aDD2;
  String? aDD3;
  String? zONE;
  String? cITY;
  String? sTATE;
  String? sTATECODE;
  String? oUTSTATE;
  String? pINCODE;
  String? mobile1;
  String? eMAIL;
  String? gSTNO;
  String? gSTTYPE;
  String? fSSAINO;
  int? aCCKM;
  String? rEGNO;
  int? creditDay;
  String? pANNO;
  String? dRUGLIC1;
  String? dRUGLIC2;
  String? dRUGLIC3;
  String? dRUGLIC4;

  Account({
    this.aCCCD,
    this.aCCNAME,
    this.pERSONNM,
    this.aDD1,
    this.aDD2,
    this.aDD3,
    this.zONE,
    this.cITY,
    this.sTATE,
    this.sTATECODE,
    this.oUTSTATE,
    this.pINCODE,
    this.mobile1,
    this.eMAIL,
    this.gSTNO,
    this.gSTTYPE,
    this.fSSAINO,
    this.aCCKM,
    this.rEGNO,
    this.creditDay,
    this.pANNO,
    this.dRUGLIC1,
    this.dRUGLIC2,
    this.dRUGLIC3,
    this.dRUGLIC4,
  });

  Account.fromJson(Map<String, dynamic> json) {
    aCCCD = json['ACC_CD'];
    aCCNAME = json['ACC_NAME'];
    pERSONNM = json['PERSON_NM'];
    aDD1 = json['ADD1'];
    aDD2 = json['ADD2'];
    aDD3 = json['ADD3'];
    zONE = json['ZONE'];
    cITY = json['CITY'];
    sTATE = json['STATE'];
    sTATECODE = json['STATE_CODE'];
    oUTSTATE = json['OUT_STATE'];
    pINCODE = json['PINCODE'];
    mobile1 = json['Mobile1'];
    eMAIL = json['EMAIL'];
    gSTNO = json['GST_NO'];
    gSTTYPE = json['GST_TYPE'];
    fSSAINO = json['FSSAI_NO'];
    aCCKM = json['ACC_KM'];
    rEGNO = json['REG_NO'];
    creditDay = json['CREDIT_DAY'];
    pANNO = json['PAN_NO'];
    dRUGLIC1 = json['DRUG_LIC1'];
    dRUGLIC2 = json['DRUG_LIC2'];
    dRUGLIC3 = json['DRUG_LIC3'];
    dRUGLIC4 = json['DRUG_LIC4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACC_CD'] = aCCCD;
    data['ACC_NAME'] = aCCNAME;
    data['PERSON_NM'] = pERSONNM;
    data['ADD1'] = aDD1;
    data['ADD2'] = aDD2;
    data['ADD3'] = aDD3;
    data['ZONE'] = zONE;
    data['CITY'] = cITY;
    data['STATE'] = sTATE;
    data['STATE_CODE'] = sTATECODE;
    data['OUT_STATE'] = oUTSTATE;
    data['PINCODE'] = pINCODE;
    data['Mobile1'] = mobile1;
    data['EMAIL'] = eMAIL;
    data['GST_NO'] = gSTNO;
    data['GST_TYPE'] = gSTTYPE;
    data['FSSAI_NO'] = fSSAINO;
    data['ACC_KM'] = aCCKM;
    data['REG_NO'] = rEGNO;
    data['CREDIT_DAY'] = creditDay;
    data['PAN_NO'] = pANNO;
    data['DRUG_LIC1'] = dRUGLIC1;
    data['DRUG_LIC2'] = dRUGLIC2;
    data['DRUG_LIC3'] = dRUGLIC3;
    data['DRUG_LIC4'] = dRUGLIC4;
    return data;
  }
}

class SalesExpandItemsModel {
  int? iD;
  String? vOUCHDT;
  String? vOUCHTIME;
  String? vOUCHNO;
  String? bOOKCD;
  String? bNO;
  String? iTEMCD;
  String? iTEMNAME;
  int? iTEMSR;
  String? sIZECD;
  int? lOOSEQUANTITY;
  int? qUANTITY;
  String? oTHERDESC;
  String? rATE1;
  String? rATE2;
  String? rATE3;
  String? rATE;
  String? dISCPERC;
  String? dISCPERC1;
  String? dISCPERC2;
  String? dISCPERC3;
  String? dISCPERC4;
  String? dISCPERC5;
  String? dISCPAMT;
  String? cHRGPERC;
  String? cHRGAMT;
  String? aMOUNT;
  String? iDISCAMT;
  String? hSAMT;
  String? tAXCD;
  String? tAXPERI;
  String? sGPERI;
  String? sGAMT;
  String? sGVAT;
  String? cGPERI;
  String? cGAMT;
  String? cGVAT;
  String? iGPERI;
  String? iGAMT;
  String? iGVAT;
  String? gCPERC;
  String? gCAMT;
  String? nETAMOUNT;
  String? sMANCODE;
  String? sMANNAME;
  String? pCD;
  int? sALESID;

  //bool? iSDELETED;
  int? sYNCID;
  String? dOSAGE;
  num? mDCNDAYS;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? uPDATEDBY;
  String? cREATEDAT;
  String? dELETEDBY;
  String? dELETEDAT;
  ItemDetail? itemDetail;
  Item? item;

  SalesExpandItemsModel(
      {this.iD,
      this.vOUCHDT,
      this.vOUCHTIME,
      this.vOUCHNO,
      this.bOOKCD,
      this.bNO,
      this.iTEMCD,
      this.iTEMNAME,
      this.iTEMSR,
      this.sIZECD,
      this.lOOSEQUANTITY,
      this.qUANTITY,
      this.oTHERDESC,
      this.rATE1,
      this.rATE2,
      this.rATE3,
      this.rATE,
      this.dISCPERC,
      this.dISCPERC1,
      this.dISCPERC2,
      this.dISCPERC3,
      this.dISCPERC4,
      this.dISCPERC5,
      this.dISCPAMT,
      this.cHRGPERC,
      this.cHRGAMT,
      this.aMOUNT,
      this.iDISCAMT,
      this.hSAMT,
      this.tAXCD,
      this.tAXPERI,
      this.sGPERI,
      this.sGAMT,
      this.sGVAT,
      this.cGPERI,
      this.cGAMT,
      this.cGVAT,
      this.iGPERI,
      this.iGAMT,
      this.iGVAT,
      this.gCPERC,
      this.gCAMT,
      this.nETAMOUNT,
      this.sMANCODE,
      this.sMANNAME,
      this.pCD,
      this.sALESID,
      //this.iSDELETED,
      this.sYNCID,
      this.dOSAGE,
      this.mDCNDAYS,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.uPDATEDBY,
      this.cREATEDAT,
      this.dELETEDBY,
      this.dELETEDAT,
      this.itemDetail,
      this.item});

  SalesExpandItemsModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    vOUCHDT = json['VOUCH_DT'];
    vOUCHTIME = json['VOUCH_TIME'];
    vOUCHNO = json['VOUCH_NO'];
    bOOKCD = json['BOOK_CD'];
    bNO = json['BNO'];
    iTEMCD = json['ITEM_CD'];
    iTEMNAME = json['ITEM_NAME'];
    iTEMSR = json['ITEM_SR'];
    sIZECD = json['SIZE_CD'];
    lOOSEQUANTITY = json['LOOSE_QUANTITY'];
    qUANTITY = json['QUANTITY'];
    oTHERDESC = json['OTHER_DESC'];
    rATE1 = json['RATE1'];
    rATE2 = json['RATE2'];
    rATE3 = json['RATE3'];
    rATE = json['RATE'];
    dISCPERC = json['DISC_PERC'];
    dISCPERC1 = json['DISC_PERC1'];
    dISCPERC2 = json['DISC_PERC2'];
    dISCPERC3 = json['DISC_PERC3'];
    dISCPERC4 = json['DISC_PERC4'];
    dISCPERC5 = json['DISC_PERC5'];
    dISCPAMT = json['DISC_PAMT'];
    cHRGPERC = json['CHRG_PERC'];
    cHRGAMT = json['CHRG_AMT'];
    aMOUNT = json['AMOUNT'];
    iDISCAMT = json['IDISC_AMT'];
    hSAMT = json['HS_AMT'];
    tAXCD = json['TAX_CD'];
    tAXPERI = json['TAX_PER_I'];
    sGPERI = json['SG_PER_I'];
    sGAMT = json['SG_AMT'];
    sGVAT = json['SG_VAT'];
    cGPERI = json['CG_PER_I'];
    cGAMT = json['CG_AMT'];
    cGVAT = json['CG_VAT'];
    iGPERI = json['IG_PER_I'];
    iGAMT = json['IG_AMT'];
    iGVAT = json['IG_VAT'];
    gCPERC = json['GC_PERC'];
    gCAMT = json['GC_AMT'];
    nETAMOUNT = json['NET_AMOUNT'];
    sMANCODE = json['SMAN_CODE'];
    sMANNAME = json['SMAN_NAME'];
    pCD = json['P_CD'];
    sALESID = json['SALES_ID'];
    //iSDELETED = json['ISDELETED'];
    sYNCID = json['SYNC_ID'];
    dOSAGE = json['DOSAGE'];
    mDCNDAYS = json['MDCN_DAYS'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    uPDATEDBY = json['UPDATED_BY'];
    cREATEDAT = json['CREATED_AT'];
    dELETEDBY = json['DELETED_BY'];
    dELETEDAT = json['DELETED_AT'];
    itemDetail = json['itemDetail'] != null
        ? ItemDetail.fromJson(json['itemDetail'])
        : null;
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['VOUCH_DT'] = vOUCHDT;
    data['VOUCH_TIME'] = vOUCHTIME;
    data['VOUCH_NO'] = vOUCHNO;
    data['BOOK_CD'] = bOOKCD;
    data['BNO'] = bNO;
    data['ITEM_CD'] = iTEMCD;
    data['ITEM_NAME'] = iTEMNAME;
    data['ITEM_SR'] = iTEMSR;
    data['SIZE_CD'] = sIZECD;
    data['LOOSE_QUANTITY'] = lOOSEQUANTITY;
    data['QUANTITY'] = qUANTITY;
    data['OTHER_DESC'] = oTHERDESC;
    data['RATE1'] = rATE1;
    data['RATE2'] = rATE2;
    data['RATE3'] = rATE3;
    data['RATE'] = rATE;
    data['DISC_PERC'] = dISCPERC;
    data['DISC_PERC1'] = dISCPERC1;
    data['DISC_PERC2'] = dISCPERC2;
    data['DISC_PERC3'] = dISCPERC3;
    data['DISC_PERC4'] = dISCPERC4;
    data['DISC_PERC5'] = dISCPERC5;
    data['DISC_PAMT'] = dISCPAMT;
    data['CHRG_PERC'] = cHRGPERC;
    data['CHRG_AMT'] = cHRGAMT;
    data['AMOUNT'] = aMOUNT;
    data['IDISC_AMT'] = iDISCAMT;
    data['HS_AMT'] = hSAMT;
    data['TAX_CD'] = tAXCD;
    data['TAX_PER_I'] = tAXPERI;
    data['SG_PER_I'] = sGPERI;
    data['SG_AMT'] = sGAMT;
    data['SG_VAT'] = sGVAT;
    data['CG_PER_I'] = cGPERI;
    data['CG_AMT'] = cGAMT;
    data['CG_VAT'] = cGVAT;
    data['IG_PER_I'] = iGPERI;
    data['IG_AMT'] = iGAMT;
    data['IG_VAT'] = iGVAT;
    data['GC_PERC'] = gCPERC;
    data['GC_AMT'] = gCAMT;
    data['NET_AMOUNT'] = nETAMOUNT;
    data['SMAN_CODE'] = sMANCODE;
    data['SMAN_NAME'] = sMANNAME;
    data['P_CD'] = pCD;
    data['SALES_ID'] = sALESID;
    //data['ISDELETED'] = iSDELETED;
    data['SYNC_ID'] = sYNCID;
    data['DOSAGE'] = dOSAGE;
    data['MDCN_DAYS'] = mDCNDAYS;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['UPDATED_BY'] = uPDATEDBY;
    data['CREATED_AT'] = cREATEDAT;
    data['DELETED_BY'] = dELETEDBY;
    data['DELETED_AT'] = dELETEDAT;
    if (itemDetail != null) {
      data['itemDetail'] = itemDetail!.toJson();
    }
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class ItemDetail {
  String? iTEMCD;
  String? sIZECD;
  num? mRP;
  String? eXPDT;
  String? pACKING;
  String? mFGDT;
  String? dESC2;

  ItemDetail(
      {this.iTEMCD,
      this.sIZECD,
      this.mRP,
      this.eXPDT,
      this.pACKING,
      this.mFGDT,
      this.dESC2});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    iTEMCD = json['ITEM_CD'];
    sIZECD = json['SIZE_CD'];
    mRP = json['MRP'];
    eXPDT = json['EXP_DT'];
    pACKING = json['PACKING'];
    mFGDT = json['MFG_DT'];
    dESC2 = json['DESC2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_CD'] = iTEMCD;
    data['SIZE_CD'] = sIZECD;
    data['MRP'] = mRP;
    data['EXP_DT'] = eXPDT;
    data['PACKING'] = pACKING;
    data['MFG_DT'] = mFGDT;
    data['DESC2'] = dESC2;
    return data;
  }
}

class Item {
  String? iTEMNAME;
  String? hSNNO;
  String? dEPTCD;
  String? dNAME;

  Item({this.iTEMNAME, this.hSNNO, this.dEPTCD, this.dNAME});

  Item.fromJson(Map<String, dynamic> json) {
    iTEMNAME = json['ITEM_NAME'];
    hSNNO = json['HSN_NO'];
    dEPTCD = json['DEPT_CD'];
    dNAME = json['DNAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_NAME'] = iTEMNAME;
    data['HSN_NO'] = hSNNO;
    data['DEPT_CD'] = dEPTCD;
    data['DNAME'] = dNAME;
    return data;
  }
}
