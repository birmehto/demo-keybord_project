class DrawerResponse {
  String? message;
  DrawerModel? data;

  DrawerResponse({this.message, this.data});

  DrawerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? DrawerModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DrawerModel {
  String? uSERCD;
  String? uSERNAME;
  String? uSERTYPE;
  String? mOBILENO;
  List<Firms>? firms;
  License? license;
  List<Modules>? modules;
  List<PROFILESETTINGS>? pROFILESETTINGS;

  DrawerModel(
      {this.uSERCD,
      this.uSERNAME,
      this.uSERTYPE,
      this.mOBILENO,
      this.firms,
      this.license,
      this.modules,
      this.pROFILESETTINGS});

  DrawerModel.fromJson(Map<String, dynamic> json) {
    uSERCD = json['USER_CD'];
    uSERNAME = json['USER_NAME'];
    uSERTYPE = json['USER_TYPE'];
    mOBILENO = json['MOBILENO'];
    if (json['firms'] != null) {
      firms = <Firms>[];
      json['firms'].forEach((v) {
        firms!.add(Firms.fromJson(v));
      });
    }
    license =
        json['license'] != null ? License.fromJson(json['license']) : null;
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
    if (json['PROFILE_SETTINGS'] != null) {
      pROFILESETTINGS = <PROFILESETTINGS>[];
      json['PROFILE_SETTINGS'].forEach((v) {
        pROFILESETTINGS!.add(PROFILESETTINGS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USER_CD'] = uSERCD;
    data['USER_NAME'] = uSERNAME;
    data['USER_TYPE'] = uSERTYPE;
    data['MOBILENO'] = mOBILENO;
    if (firms != null) {
      data['firms'] = firms!.map((v) => v.toJson()).toList();
    }
    if (license != null) {
      data['license'] = license!.toJson();
    }
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    if (pROFILESETTINGS != null) {
      data['PROFILE_SETTINGS'] =
          pROFILESETTINGS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Firms {
  String? fIRMID;
  String? cUSTID;
  String? fIRMNAME;

  Firms({this.fIRMID, this.cUSTID, this.fIRMNAME});

  Firms.fromJson(Map<String, dynamic> json) {
    fIRMID = json['FIRM_ID'];
    cUSTID = json['CUST_ID'];
    fIRMNAME = json['FIRM_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FIRM_ID'] = fIRMID;
    data['CUST_ID'] = cUSTID;
    data['FIRM_NAME'] = fIRMNAME;
    return data;
  }
}

class License {
  String? lICSTARTDATE;
  String? lICENDDATE;
  int? mAXFIRMS;
  int? mAXUSERS;
  String? lASTRENEWALDATE;

  License(
      {this.lICSTARTDATE,
      this.lICENDDATE,
      this.mAXFIRMS,
      this.mAXUSERS,
      this.lASTRENEWALDATE});

  License.fromJson(Map<String, dynamic> json) {
    lICSTARTDATE = json['LIC_START_DATE'];
    lICENDDATE = json['LIC_END_DATE'];
    mAXFIRMS = json['MAX_FIRMS'];
    mAXUSERS = json['MAX_USERS'];
    lASTRENEWALDATE = json['LAST_RENEWAL_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LIC_START_DATE'] = lICSTARTDATE;
    data['LIC_END_DATE'] = lICENDDATE;
    data['MAX_FIRMS'] = mAXFIRMS;
    data['MAX_USERS'] = mAXUSERS;
    data['LAST_RENEWAL_DATE'] = lASTRENEWALDATE;
    return data;
  }
}

class Modules {
  int? iD;
  String? uSERCD;
  String? mODULENO;
  bool? rEADRIGHT;
  bool? wRITERIGHT;
  bool? uPDATERIGHT;
  bool? dELETERIGHT;
  bool? pRINTRIGHT;
  String? cREATEDBY;
  String? cREATEDAPPTYPE;
  String? uPDATEDAT;
  String? cREATEDAT;
  Module? module;

  Modules(
      {this.iD,
      this.uSERCD,
      this.mODULENO,
      this.rEADRIGHT,
      this.wRITERIGHT,
      this.uPDATERIGHT,
      this.dELETERIGHT,
      this.pRINTRIGHT,
      this.cREATEDBY,
      this.cREATEDAPPTYPE,
      this.uPDATEDAT,
      this.cREATEDAT,
      this.module});

  Modules.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uSERCD = json['USER_CD'];
    mODULENO = json['MODULE_NO'];
    rEADRIGHT = json['READ_RIGHT'];
    wRITERIGHT = json['WRITE_RIGHT'];
    uPDATERIGHT = json['UPDATE_RIGHT'];
    dELETERIGHT = json['DELETE_RIGHT'];
    pRINTRIGHT = json['PRINT_RIGHT'];
    cREATEDBY = json['CREATED_BY'];
    cREATEDAPPTYPE = json['CREATED_APP_TYPE'];
    uPDATEDAT = json['UPDATED_AT'];
    cREATEDAT = json['CREATED_AT'];
    module = json['module'] != null ? Module.fromJson(json['module']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['USER_CD'] = uSERCD;
    data['MODULE_NO'] = mODULENO;
    data['READ_RIGHT'] = rEADRIGHT;
    data['WRITE_RIGHT'] = wRITERIGHT;
    data['UPDATE_RIGHT'] = uPDATERIGHT;
    data['DELETE_RIGHT'] = dELETERIGHT;
    data['PRINT_RIGHT'] = pRINTRIGHT;
    data['CREATED_BY'] = cREATEDBY;
    data['CREATED_APP_TYPE'] = cREATEDAPPTYPE;
    data['UPDATED_AT'] = uPDATEDAT;
    data['CREATED_AT'] = cREATEDAT;
    if (module != null) {
      data['module'] = module!.toJson();
    }
    return data;
  }
}

class Module {
  List<String>? uSERTYPE;
  String? mODULENO;
  String? mODULENAME;
  String? mODULETYPE;

  Module({this.uSERTYPE, this.mODULENO, this.mODULENAME, this.mODULETYPE});

  Module.fromJson(Map<String, dynamic> json) {
    uSERTYPE = json['USER_TYPE'].cast<String>();
    mODULENO = json['MODULE_NO'];
    mODULENAME = json['MODULE_NAME'];
    mODULETYPE = json['MODULE_TYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['USER_TYPE'] = uSERTYPE;
    data['MODULE_NO'] = mODULENO;
    data['MODULE_NAME'] = mODULENAME;
    data['MODULE_TYPE'] = mODULETYPE;
    return data;
  }
}

class PROFILESETTINGS {
  int? sId;
  String? sETTINGNAME;
  String? vARIABLE;
  String? vALUE;
  int? sYNCID;

  PROFILESETTINGS(
      {this.sId, this.sETTINGNAME, this.vARIABLE, this.vALUE, this.sYNCID});

  PROFILESETTINGS.fromJson(Map<String, dynamic> json) {
    sId = json['sId'];
    sETTINGNAME = json['SETTING_NAME'];
    vARIABLE = json['VARIABLE'];
    vALUE = json['VALUE'];
    sYNCID = json['SYNC_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sId'] = sId;
    data['SETTING_NAME'] = sETTINGNAME;
    data['VARIABLE'] = vARIABLE;
    data['VALUE'] = vALUE;
    data['SYNC_ID'] = sYNCID;
    return data;
  }
}
