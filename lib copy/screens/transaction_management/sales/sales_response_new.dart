class SalesResponseNew {
  List<SalesModelNew>? sales;

  SalesResponseNew({this.sales});

  SalesResponseNew.fromJson(Map<String, dynamic> json) {
    if (json['sales'] != null) {
      sales = <SalesModelNew>[];
      json['sales'].forEach((v) {
        sales!.add(SalesModelNew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sales != null) {
      data['sales'] = sales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesModelNew {
  String? bILLNO;
  String? bOOKCD;
  String? vOUCHDT;
  String? pARTYCD;
  String? aCCNAME;
  int? sALESID;
  String? sMANCD;
  String? sMANNAME;
  String? dMANCD;
  String? dMANNAME;
  String? cASHAMT;
  String? bANKAMT;
  String? cARDAMT;
  String? uPIAMT;
  String? nETAMT;
  String? mODULENO;

  SalesModelNew(
      {this.bILLNO,
      this.bOOKCD,
      this.vOUCHDT,
      this.pARTYCD,
      this.aCCNAME,
      this.sALESID,
      this.sMANCD,
      this.sMANNAME,
      this.dMANCD,
      this.dMANNAME,
      this.cASHAMT,
      this.bANKAMT,
      this.cARDAMT,
      this.uPIAMT,
      this.nETAMT,
      this.mODULENO});

  SalesModelNew.fromJson(Map<String, dynamic> json) {
    bILLNO = json['BILL_NO'];
    bOOKCD = json['BOOK_CD'];
    vOUCHDT = json['VOUCH_DT'];
    pARTYCD = json['PARTY_CD'];
    aCCNAME = json['ACC_NAME'];
    sALESID = json['SALES_ID'];
    sMANCD = json['SMAN_CD'];
    sMANNAME = json['SMAN_NAME'];
    dMANCD = json['DMAN_CD'];
    dMANNAME = json['DMAN_NAME'];
    cASHAMT = json['CASH_AMT'];
    bANKAMT = json['BANK_AMT'];
    cARDAMT = json['CARD_AMT'];
    uPIAMT = json['UPI_AMT'];
    nETAMT = json['NET_AMT'];
    mODULENO = json['MODULE_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BILL_NO'] = bILLNO;
    data['BOOK_CD'] = bOOKCD;
    data['VOUCH_DT'] = vOUCHDT;
    data['PARTY_CD'] = pARTYCD;
    data['ACC_NAME'] = aCCNAME;
    data['SALES_ID'] = sALESID;
    data['SMAN_CD'] = sMANCD;
    data['SMAN_NAME'] = sMANNAME;
    data['DMAN_CD'] = dMANCD;
    data['DMAN_NAME'] = dMANNAME;
    data['CASH_AMT'] = cASHAMT;
    data['BANK_AMT'] = bANKAMT;
    data['CARD_AMT'] = cARDAMT;
    data['UPI_AMT'] = uPIAMT;
    data['NET_AMT'] = nETAMT;
    data['MODULE_NO'] = mODULENO;
    return data;
  }
}
