class AppURL {

  static const String baseURL =
      "https://apidev.arhamerp.com/api/"; //TODO : Old Swagger Live

  //auth region
  static String loginURL = "${baseURL}login";
  static String getFirmURL = "${baseURL}firm";
  static String changeFirmURL = "${baseURL}change-firm";
  static String signUPURL = "${baseURL}signup";

  //end region

  //tax region
  static String taxURL = "${baseURL}master-entry/tax";

  //end region

  //item region
  static String itemURL = "${baseURL}master-entry/product";
  static String batchURL = "${baseURL}item-detail/delete";

  //end region

  //drawer region
  static String drawerURL = "${baseURL}profile";

  //end region

  //sales region
  static String productsPartyURL = "${baseURL}product/partys";
  static String productsURL = "${baseURL}pos-product";
  static String salesURL = "${baseURL}sales";
  static String salesReportURL = "${baseURL}report/sales";
  static String salesReportByIdURL = "${baseURL}salesById";
  static String salesItemDeleteURL = "${baseURL}sales/saleItem";
  static String salesByIdURL = "${baseURL}sales";

  //end region
}
