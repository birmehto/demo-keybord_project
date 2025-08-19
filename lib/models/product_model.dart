class ProductResponse {
  String? message;
  List<ProductModel>? data;

  ProductResponse({this.message, this.data});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductModel>[];
      json['data'].forEach((v) {
        data!.add(ProductModel.fromJson(v));
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

  @override
  String toString() {
    return 'ProductResponse(ProductModel: $data)';
  }
}

class ProductModel {
  String? iTEMCD2;
  num? nRATE;
  num? aVLSTK;
  String? eXDT;
  String? rACKNO;
  String? iTEMCAT;
  String? sUBCAT;
  String? iTEMBRAND;
  String? iTEMCD;
  String? iTEMNAME;
  String? iTEMSNAME;
  String? iTEMLNAME;
  String? dEPTCD;
  String? dNAME;
  num? gSTPERC;
  num? cESS;
  String? tAXINCLUDEDYN;
  String? iSSERVICES;
  String? hSNNO;
  String? uNIT;
  String? lASTEDIT;
  String? iTEMTYPE;
  num? pRATE;
  num? sRATE1;
  num? sRATE2;
  num? sRATE3;
  num? sRATE4;
  num? sRATE5;
  num? mRP;
  num? tLAND;
  String? fRMLSRT1;
  num? pDISC;
  num? sDISC;
  num? sDISC1;
  num? cSTK;
  num? oRSTK;
  num? mINSTK;
  num? rEORDERQTY;
  String? sTOCKEFFECT;
  num? gSTSTAXCD;
  String? lASTSIZE;
  String? bLACKLIST;
  num? sYNCID;
  String? iTEMGRADE;
  String? iTEMDESC;
  String? sEARCHTEXT;
  String? bARCODENO1;
  String? bARCODENO2;
  String? bARCODENO3;
  String? bARCODENO4;
  String? bARCODENO5;
  String? bARCODENO6;
  String? bARCODENO7;
  String? bARCODENO8;
  String? bARCODENO9;
  String? bARCODENO10;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;
  List<Itemdtls>? itemdtls;
  Deptment? deptment;

  //String? itemImage;
  ItemImage? itemImage;

  ProductModel(
      {this.iTEMCD2,
      this.nRATE,
      this.aVLSTK,
      this.eXDT,
      this.rACKNO,
      this.iTEMCAT,
      this.sUBCAT,
      this.iTEMBRAND,
      this.iTEMCD,
      this.iTEMNAME,
      this.iTEMSNAME,
      this.iTEMLNAME,
      this.dEPTCD,
      this.dNAME,
      this.gSTPERC,
      this.cESS,
      this.tAXINCLUDEDYN,
      this.iSSERVICES,
      this.hSNNO,
      this.uNIT,
      this.lASTEDIT,
      this.iTEMTYPE,
      this.pRATE,
      this.sRATE1,
      this.sRATE2,
      this.sRATE3,
      this.sRATE4,
      this.sRATE5,
      this.mRP,
      this.tLAND,
      this.fRMLSRT1,
      this.pDISC,
      this.sDISC,
      this.sDISC1,
      this.cSTK,
      this.oRSTK,
      this.mINSTK,
      this.rEORDERQTY,
      this.sTOCKEFFECT,
      this.gSTSTAXCD,
      this.lASTSIZE,
      this.bLACKLIST,
      this.sYNCID,
      this.iTEMGRADE,
      this.iTEMDESC,
      this.sEARCHTEXT,
      this.bARCODENO1,
      this.bARCODENO2,
      this.bARCODENO3,
      this.bARCODENO4,
      this.bARCODENO5,
      this.bARCODENO6,
      this.bARCODENO7,
      this.bARCODENO8,
      this.bARCODENO9,
      this.bARCODENO10,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.cREATEDAT,
      this.itemdtls,
      this.deptment,
      this.itemImage});

  ProductModel.fromJson(Map<String, dynamic> json) {
    iTEMCD2 = json['ITEM_CD2'];
    nRATE = json['NRATE'];
    aVLSTK = json['AVL_STK'];
    eXDT = json['EX_DT'];
    rACKNO = json['RACK_NO'];
    iTEMCAT = json['ITEM_CAT'];
    sUBCAT = json['SUBCAT'];
    iTEMBRAND = json['ITEM_BRAND'];
    iTEMCD = json['ITEM_CD'];
    iTEMNAME = json['ITEM_NAME'];
    iTEMSNAME = json['ITEM_SNAME'];
    iTEMLNAME = json['ITEM_LNAME'];
    dEPTCD = json['DEPT_CD'];
    dNAME = json['DNAME'];
    gSTPERC = json['GST_PERC'];
    cESS = json['CESS'];
    tAXINCLUDEDYN = json['TAX_INCLUDED_YN'];
    iSSERVICES = json['IS_SERVICES'];
    hSNNO = json['HSN_NO'];
    uNIT = json['UNIT'];
    lASTEDIT = json['LAST_EDIT'];
    iTEMTYPE = json['ITEM_TYPE'];
    pRATE = json['PRATE'];
    sRATE1 = json['SRATE1'];
    sRATE2 = json['SRATE2'];
    sRATE3 = json['SRATE3'];
    sRATE4 = json['SRATE4'];
    sRATE5 = json['SRATE5'];
    mRP = json['MRP'];
    tLAND = json['T_LAND'];
    fRMLSRT1 = json['FRML_SRT1'];
    pDISC = json['PDISC'];
    sDISC = json['SDISC'];
    sDISC1 = json['SDISC1'];
    cSTK = json['C_STK'];
    oRSTK = json['OR_STK'];
    mINSTK = json['MIN_STK'];
    rEORDERQTY = json['RE_ORDER_QTY'];
    sTOCKEFFECT = json['STOCK_EFFECT'];
    gSTSTAXCD = json['GST_STAXCD'];
    lASTSIZE = json['LAST_SIZE'];
    bLACKLIST = json['BLACKLIST'];
    sYNCID = json['SYNC_ID'];
    iTEMGRADE = json['ITEM_GRADE'];
    iTEMDESC = json['ITEM_DESC'];
    sEARCHTEXT = json['SEARCH_TEXT'];
    bARCODENO1 = json['BARCODE_NO1'];
    bARCODENO2 = json['BARCODE_NO2'];
    bARCODENO3 = json['BARCODE_NO3'];
    bARCODENO4 = json['BARCODE_NO4'];
    bARCODENO5 = json['BARCODE_NO5'];
    bARCODENO6 = json['BARCODE_NO6'];
    bARCODENO7 = json['BARCODE_NO7'];
    bARCODENO8 = json['BARCODE_NO8'];
    bARCODENO9 = json['BARCODE_NO9'];
    bARCODENO10 = json['BARCODE_NO10'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
    if (json['itemdtls'] != null) {
      itemdtls = <Itemdtls>[];
      json['itemdtls'].forEach((v) {
        itemdtls!.add(Itemdtls.fromJson(v));
      });
    }
    deptment =
        json['deptment'] != null ? Deptment.fromJson(json['deptment']) : null;
    //itemImage = json['item_image'];
    itemImage = json['item_image'] != null
        ? ItemImage.fromJson(json['item_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_CD2'] = iTEMCD2;
    data['NRATE'] = nRATE;
    data['AVL_STK'] = aVLSTK;
    data['EX_DT'] = eXDT;
    data['RACK_NO'] = rACKNO;
    data['ITEM_CAT'] = iTEMCAT;
    data['SUBCAT'] = sUBCAT;
    data['ITEM_BRAND'] = iTEMBRAND;
    data['ITEM_CD'] = iTEMCD;
    data['ITEM_NAME'] = iTEMNAME;
    data['ITEM_SNAME'] = iTEMSNAME;
    data['ITEM_LNAME'] = iTEMLNAME;
    data['DEPT_CD'] = dEPTCD;
    data['DNAME'] = dNAME;
    data['GST_PERC'] = gSTPERC;
    data['CESS'] = cESS;
    data['TAX_INCLUDED_YN'] = tAXINCLUDEDYN;
    data['IS_SERVICES'] = iSSERVICES;
    data['HSN_NO'] = hSNNO;
    data['UNIT'] = uNIT;
    data['LAST_EDIT'] = lASTEDIT;
    data['ITEM_TYPE'] = iTEMTYPE;
    data['PRATE'] = pRATE;
    data['SRATE1'] = sRATE1;
    data['SRATE2'] = sRATE2;
    data['SRATE3'] = sRATE3;
    data['SRATE4'] = sRATE4;
    data['SRATE5'] = sRATE5;
    data['MRP'] = mRP;
    data['T_LAND'] = tLAND;
    data['FRML_SRT1'] = fRMLSRT1;
    data['PDISC'] = pDISC;
    data['SDISC'] = sDISC;
    data['SDISC1'] = sDISC1;
    data['C_STK'] = cSTK;
    data['OR_STK'] = oRSTK;
    data['MIN_STK'] = mINSTK;
    data['RE_ORDER_QTY'] = rEORDERQTY;
    data['STOCK_EFFECT'] = sTOCKEFFECT;
    data['GST_STAXCD'] = gSTSTAXCD;
    data['LAST_SIZE'] = lASTSIZE;
    data['BLACKLIST'] = bLACKLIST;
    data['SYNC_ID'] = sYNCID;
    data['ITEM_GRADE'] = iTEMGRADE;
    data['ITEM_DESC'] = iTEMDESC;
    data['SEARCH_TEXT'] = sEARCHTEXT;
    data['BARCODE_NO1'] = bARCODENO1;
    data['BARCODE_NO2'] = bARCODENO2;
    data['BARCODE_NO3'] = bARCODENO3;
    data['BARCODE_NO4'] = bARCODENO4;
    data['BARCODE_NO5'] = bARCODENO5;
    data['BARCODE_NO6'] = bARCODENO6;
    data['BARCODE_NO7'] = bARCODENO7;
    data['BARCODE_NO8'] = bARCODENO8;
    data['BARCODE_NO9'] = bARCODENO9;
    data['BARCODE_NO10'] = bARCODENO10;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    if (itemdtls != null) {
      data['itemdtls'] = itemdtls!.map((v) => v.toJson()).toList();
    }
    if (deptment != null) {
      data['deptment'] = deptment!.toJson();
    }
    //data['item_image'] = itemImage;
    if (itemImage != null) {
      data['item_image'] = itemImage!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ProductModel(ItemCD: $iTEMCD, ItemName: $iTEMNAME, ItemDtls: $itemdtls)';
  }
}

class Itemdtls {
  num? aVLSTK;
  String? iTEMCD;
  num? iTEMSR;
  String? sIZECD;
  num? sIZEIDX;
  String? iTEMBARCDNO;
  String? bLACKLIST;
  num? pURRATE;
  num? pRATETAX;
  num? oPRATE;
  num? cLRATE;
  num? sALERATE1;
  num? sALERATE2;
  num? sALERATE3;
  num? sALERATE4;
  num? sALERATE5;
  num? sALERATE6;
  num? sALERATE7;
  num? sALERATE8;
  num? mRP;
  num? cOMRATE;
  num? pURDISC;
  num? sALEDISC;
  num? sALEDISC1;
  num? sALEDISC2;
  num? sALEDISC3;
  num? sIODISC;
  num? oPSTK;
  num? dRSTK;
  num? cRSTK;
  num? cLSTK;
  num? oRSTK;
  num? oPDESC;
  num? cLDESC;
  num? dRBASE;
  num? dRFR;
  num? cRBASE;
  num? cRFR;
  num? mINSTK;
  num? rOSTK;
  num? aCTUALSTK;
  String? mFGDT;
  String? dESC1;
  String? bATCHNO;
  String? eXPDT;
  String? pACKING;
  String? dESC2;
  String? dESC3;
  num? sYNCID;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;

  Itemdtls(
      {this.aVLSTK,
      this.iTEMCD,
      this.iTEMSR,
      this.sIZECD,
      this.sIZEIDX,
      this.iTEMBARCDNO,
      this.bLACKLIST,
      this.pURRATE,
      this.pRATETAX,
      this.oPRATE,
      this.cLRATE,
      this.sALERATE1,
      this.sALERATE2,
      this.sALERATE3,
      this.sALERATE4,
      this.sALERATE5,
      this.sALERATE6,
      this.sALERATE7,
      this.sALERATE8,
      this.mRP,
      this.cOMRATE,
      this.pURDISC,
      this.sALEDISC,
      this.sALEDISC1,
      this.sALEDISC2,
      this.sALEDISC3,
      this.sIODISC,
      this.oPSTK,
      this.dRSTK,
      this.cRSTK,
      this.cLSTK,
      this.oRSTK,
      this.oPDESC,
      this.cLDESC,
      this.dRBASE,
      this.dRFR,
      this.cRBASE,
      this.cRFR,
      this.mINSTK,
      this.rOSTK,
      this.aCTUALSTK,
      this.mFGDT,
      this.dESC1,
      this.bATCHNO,
      this.eXPDT,
      this.pACKING,
      this.dESC2,
      this.dESC3,
      this.sYNCID,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.cREATEDAT});

  Itemdtls.fromJson(Map<String, dynamic> json) {
    aVLSTK = json['AVL_STK'];
    iTEMCD = json['ITEM_CD'];
    iTEMSR = json['ITEM_SR'];
    sIZECD = json['SIZE_CD'];
    sIZEIDX = json['SIZE_IDX'];
    iTEMBARCDNO = json['ITEM_BARCD_NO'];
    bLACKLIST = json['BLACKLIST'];
    pURRATE = json['PUR_RATE'];
    pRATETAX = json['PRATE_TAX'];
    oPRATE = json['OP_RATE'];
    cLRATE = json['CL_RATE'];
    sALERATE1 = json['SALE_RATE1'];
    sALERATE2 = json['SALE_RATE2'];
    sALERATE3 = json['SALE_RATE3'];
    sALERATE4 = json['SALE_RATE4'];
    sALERATE5 = json['SALE_RATE5'];
    sALERATE6 = json['SALE_RATE6'];
    sALERATE7 = json['SALE_RATE7'];
    sALERATE8 = json['SALE_RATE8'];
    mRP = json['MRP'];
    cOMRATE = json['COM_RATE'];
    pURDISC = json['PUR_DISC'];
    sALEDISC = json['SALE_DISC'];
    sALEDISC1 = json['SALE_DISC1'];
    sALEDISC2 = json['SALE_DISC2'];
    sALEDISC3 = json['SALE_DISC3'];
    sIODISC = json['SIO_DISC'];
    oPSTK = json['OP_STK'];
    dRSTK = json['DR_STK'];
    cRSTK = json['CR_STK'];
    cLSTK = json['CL_STK'];
    oRSTK = json['OR_STK'];
    oPDESC = json['OP_DESC'];
    cLDESC = json['CL_DESC'];
    dRBASE = json['DR_BASE'];
    dRFR = json['DR_FR'];
    cRBASE = json['CR_BASE'];
    cRFR = json['CR_FR'];
    mINSTK = json['MIN_STK'];
    rOSTK = json['RO_STK'];
    aCTUALSTK = json['ACTUAL_STK'];
    mFGDT = json['MFG_DT'];
    dESC1 = json['DESC1'];
    bATCHNO = json['BATCH_NO'];
    eXPDT = json['EXP_DT'];
    pACKING = json['PACKING'];
    dESC2 = json['DESC2'];
    dESC3 = json['DESC3'];
    sYNCID = json['SYNC_ID'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AVL_STK'] = aVLSTK;
    data['ITEM_CD'] = iTEMCD;
    data['ITEM_SR'] = iTEMSR;
    data['SIZE_CD'] = sIZECD;
    data['SIZE_IDX'] = sIZEIDX;
    data['ITEM_BARCD_NO'] = iTEMBARCDNO;
    data['BLACKLIST'] = bLACKLIST;
    data['PUR_RATE'] = pURRATE;
    data['PRATE_TAX'] = pRATETAX;
    data['OP_RATE'] = oPRATE;
    data['CL_RATE'] = cLRATE;
    data['SALE_RATE1'] = sALERATE1;
    data['SALE_RATE2'] = sALERATE2;
    data['SALE_RATE3'] = sALERATE3;
    data['SALE_RATE4'] = sALERATE4;
    data['SALE_RATE5'] = sALERATE5;
    data['SALE_RATE6'] = sALERATE6;
    data['SALE_RATE7'] = sALERATE7;
    data['SALE_RATE8'] = sALERATE8;
    data['MRP'] = mRP;
    data['COM_RATE'] = cOMRATE;
    data['PUR_DISC'] = pURDISC;
    data['SALE_DISC'] = sALEDISC;
    data['SALE_DISC1'] = sALEDISC1;
    data['SALE_DISC2'] = sALEDISC2;
    data['SALE_DISC3'] = sALEDISC3;
    data['SIO_DISC'] = sIODISC;
    data['OP_STK'] = oPSTK;
    data['DR_STK'] = dRSTK;
    data['CR_STK'] = cRSTK;
    data['CL_STK'] = cLSTK;
    data['OR_STK'] = oRSTK;
    data['OP_DESC'] = oPDESC;
    data['CL_DESC'] = cLDESC;
    data['DR_BASE'] = dRBASE;
    data['DR_FR'] = dRFR;
    data['CR_BASE'] = cRBASE;
    data['CR_FR'] = cRFR;
    data['MIN_STK'] = mINSTK;
    data['RO_STK'] = rOSTK;
    data['ACTUAL_STK'] = aCTUALSTK;
    data['MFG_DT'] = mFGDT;
    data['DESC1'] = dESC1;
    data['BATCH_NO'] = bATCHNO;
    data['EXP_DT'] = eXPDT;
    data['PACKING'] = pACKING;
    data['DESC2'] = dESC2;
    data['DESC3'] = dESC3;
    data['SYNC_ID'] = sYNCID;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    return data;
  }

  @override
  String toString() {
    return 'ItemDtls(ItemCD: $iTEMCD, SizeCD: $sIZECD, PurRate: $pURRATE)';
  }
}

class Deptment {
  String? dEPTCD;
  String? dEPTNAME;
  String? gROUPING;
  num? sYNCID;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;

  Deptment(
      {this.dEPTCD,
      this.dEPTNAME,
      this.gROUPING,
      this.sYNCID,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.cREATEDAT});

  Deptment.fromJson(Map<String, dynamic> json) {
    dEPTCD = json['DEPT_CD'];
    dEPTNAME = json['DEPT_NAME'];
    gROUPING = json['GROUPING'];
    sYNCID = json['SYNC_ID'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DEPT_CD'] = dEPTCD;
    data['DEPT_NAME'] = dEPTNAME;
    data['GROUPING'] = gROUPING;
    data['SYNC_ID'] = sYNCID;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    return data;
  }
}

class ItemImage {
  List<String>? iTEMIMG;
  String? iTEMCD;
  String? iTEMIMG1;
  String? iTEMIMG2;
  String? iTEMIMG3;
  String? iTEMIMG4;
  String? iTEMIMG5;
  String? iTEMIMG6;
  int? sYNCID;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;

  ItemImage(
      {this.iTEMIMG,
      this.iTEMCD,
      this.iTEMIMG1,
      this.iTEMIMG2,
      this.iTEMIMG3,
      this.iTEMIMG4,
      this.iTEMIMG5,
      this.iTEMIMG6,
      this.sYNCID,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.cREATEDAT});

  ItemImage.fromJson(Map<String, dynamic> json) {
    iTEMIMG = json['ITEM_IMG'].cast<String>();
    iTEMCD = json['ITEM_CD'];
    iTEMIMG1 = json['ITEM_IMG1'];
    iTEMIMG2 = json['ITEM_IMG2'];
    iTEMIMG3 = json['ITEM_IMG3'];
    iTEMIMG4 = json['ITEM_IMG4'];
    iTEMIMG5 = json['ITEM_IMG5'];
    iTEMIMG6 = json['ITEM_IMG6'];
    sYNCID = json['SYNC_ID'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ITEM_IMG'] = iTEMIMG;
    data['ITEM_CD'] = iTEMCD;
    data['ITEM_IMG1'] = iTEMIMG1;
    data['ITEM_IMG2'] = iTEMIMG2;
    data['ITEM_IMG3'] = iTEMIMG3;
    data['ITEM_IMG4'] = iTEMIMG4;
    data['ITEM_IMG5'] = iTEMIMG5;
    data['ITEM_IMG6'] = iTEMIMG6;
    data['SYNC_ID'] = sYNCID;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    return data;
  }
}
