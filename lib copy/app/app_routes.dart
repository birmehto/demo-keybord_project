import 'package:demo/screens/dashboard/dashboard_binding.dart';
import 'package:demo/screens/dashboard/dashboard_view.dart';
import 'package:demo/screens/drawer/app_drawer_view.dart';
import 'package:demo/screens/others/splash/splash_view.dart';

import 'package:demo/screens/transaction_management/sales/sales_binding.dart';
import 'package:demo/screens/transaction_management/sales/sales_view.dart';
import 'package:demo/screens/auth/login/login_binding.dart';
import 'package:demo/screens/auth/login/login_view.dart';
import 'package:demo/screens/transaction_management/web_sales/web_general_sales/web_general_sales_binding.dart';
import 'package:demo/screens/transaction_management/web_sales/web_general_sales/web_general_sales_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const initialRoute = '/splash_route';
  static const welcomeRoute = '/welcome_route';

  //auth region
  static const loginRoute = '/login_route';
  static const forgotPasswordRoute = '/forgot_password_route';
  static const signUpRoute = '/sign_up_route';

  //end region

  //dashboard region
  static const dashBoardRoute = '/dash_board_route';

  //end region

  //profile region
  static const profileRoute = '/profile_route';

  //end region

  //settings region
  static const settingsRoute = '/settings_route';
  static const changePasswordRoute = '/change_password_route';

  //end region

  //department region
  static const departmentRoute = '/department_route';

  //end region

  //narration region
  static const narrationRoute = '/narration_route';

  //end region

  //group region
  static const groupRoute = '/group_route';
  static const addGroupRoute = '/add_group_route';

  //end region

  //salesman region
  static const salesmanRoute = '/salesman_route';
  static const addSalesmanRoute = '/add_salesman_route';

  //end region

  //deliveryman region
  static const deliverymanRoute = '/deliveryman_route';
  static const addDeliverymanRoute = '/add_deliveryman_route';

  //end region

  //doctor region
  static const doctorRoute = '/doctor_route';
  static const addDoctorRoute = '/add_doctor_route';

  //end region

  //tax region
  static const taxRoute = '/tax_route';
  static const addTaxRoute = '/add_tax_route';

  //end region

  //company region
  static const companyRoute = '/company_route';
  static const addCompanyRoute = '/add_company_route';
  static const detailsCompanyRoute = '/details_company_route';

  //end region

  //User region
  static const userRoute = '/user_route';
  static const addUserRoute = '/add_user_route';
  static const detailsUserRoute = '/details_user_route';
  static const assignModuleRoute = '/assign_module_route';

  //end region

  //product region
  static const productRoute = '/product_route';
  static const addProductRoute = '/add_product_route';
  static const detailsProductRoute = '/details_product_route';

  //end region

  //batch region
  static const batchRoute = '/batch_route';
  static const addBatchRoute = '/add_batch_route';
  static const detailsBatchRoute = '/details_batch_route';

  //end region

  //account region
  static const accountRoute = '/account_route';
  static const addAccountRoute = '/add_account_route';
  static const detailsAccountRoute = '/details_account_route';

  //end region

  //customer region
  static const customerRoute = '/customer_route';
  static const addCustomerRoute = '/add_customer_route';
  static const detailsCustomerRoute = '/details_customer_route';

  //end region

  //supplier region
  static const supplierRoute = '/supplier_route';
  static const addSupplierRoute = '/add_supplier_route';
  static const detailsSupplierRoute = '/details_supplier_route';

  //end region

  //patient region
  static const patientRoute = '/patient_route';
  static const addPatientRoute = '/add_patient_route';
  static const detailsPatientRoute = '/details_patient_route';

  //end region

  //drawer region
  static const drawerRoute = '/drawer_route';

  //end region

  //payment region
  static const paymentOnAcRoute = '/payment_on_ac_route';
  static const addPaymentOnAcRoute = '/add_payment_on_ac_route';
  static const editPaymentOnAcRoute = '/edit_payment_on_ac_route';
  static const detailsPaymentOnAcRoute = '/details_payment_on_ac_route';
  static const paymentBillwiseRoute = '/payment_billwise_route';
  static const paymentReportRoute = '/payment_report_route';
  static const paymentConfirmRoute = '/payment_confirm_route';

  //end region

  //income region
  static const incomeOnAcRoute = '/income_on_ac_route';
  static const addIncomeOnAcRoute = '/add_income_on_ac_route';

  //end region

  //receipt region
  static const receiptOnAcRoute = '/receipt_on_ac_route';
  static const addReceiptOnAcRoute = '/add_receipt_on_ac_route';
  static const editReceiptOnAcRoute = '/edit_receipt_on_ac_route';
  static const detailsReceiptOnAcRoute = '/details_receipt_on_ac_route';
  static const receiptBillwiseRoute = '/receipt_billwise_route';
  static const receiptReportRoute = '/receipt_report_route';
  static const receiptConfirmRoute = '/receipt_confirm_route';

  //end region

  //expense region
  static const expenseOnAcRoute = '/expense_on_ac_route';
  static const addExpenseOnAcRoute = '/add_expense_on_ac_route';

  //end region

  //contra region
  static const contraOnAcRoute = '/contra_on_ac_route';
  static const addContraOnAcRoute = '/add_contra_on_ac_route';

  //end region

  //pos dashboard sales region
  static const posDashboardRoute = '/pos_dashboard_route';
  static const posSummaryItemRoute = '/pos_sales_summary_item_route';

  //end region

  //shopping cart region
  static const shoppingCartRoute = '/shopping_cart_route';

  //end region

  //purchase region
  static const purchaseRoute = '/purchase_route';
  static const addPurchaseRoute = '/add_purchase_route';
  static const addCSVPurchaseRoute = '/add_csv_purchase_route';
  static const purchaseSummaryRoute = '/purchase_summary_route';
  static const purchaseItemAddRoute = '/purchase_item_add_route';

  //end region

  //purchase return region
  static const purchaseReturnRoute = '/purchase_return_route';
  static const addPurchaseReturnRoute = '/add_purchase_return_route';
  static const addCSVPurchaseReturnRoute = '/add_csv_purchase_return_route';
  static const purchaseReturnSummaryRoute = '/purchase_return_summary_route';
  static const purchaseReturnItemAddRoute = '/purchase_return_item_add_route';

  //end region

  //expense region
  static const expenseRoute = '/expense_route';
  static const addExpenseRoute = '/add_expense_route';
  static const detailsExpenseRoute = '/details_expense_route';

  //end region

  //income region
  static const incomeRoute = '/income_route';
  static const addIncomeRoute = '/add_income_route';
  static const detailsIncomeRoute = '/details_income_route';

  //end region

  //smart calculator sales region
  static const smartCalculatorRoute = '/smart_calculator_route';
  static const smartCalculatorSaveRoute = '/smart_calculator_save_route';

  //end region

  //ocr bill region
  static const invoiceBillRoute = '/invoice_bill_route';
  static const ocrBillRoute = '/ocr_bill_route';

  //end region

  //pharmacy sales region
  static const pharmacySalesItemRoute = '/pharmacy_sales_item_route';
  static const pharmacySalesAddItemRoute = '/pharmacy_sales_add_item_route';
  static const pharmacySalesSummaryItemRoute =
      '/pharmacy_sales_summary_item_route';

  //end region

  //general sales region
  static const detailsSalesRoute = '/details_sales_route';
  static const generalSalesAddRoute = '/general_sales_add_route';
  static const generalSalesItemAddRoute = '/general_sales_item_add_route';
  static const generalSalesSummaryRoute = '/general_sales_summary_route';

  //end region

  //sales register region
  static const salesRegisterRoute = '/sales_register_route';

  //end region

  //order history region
  static const orderHistoryRoute = '/order_history_route';

  //end region

  //sales region
  static const salesRoute = '/sales_route';

  //end region

  //outstanding region
  static const outstandingReceivableRoute = '/outstanding_receivable_route';
  static const outstandingPayableRoute = '/outstanding_payable_route';

  //end region

  //stock in region
  static const stockInRoute = '/stock_in_route';
  static const addStockInRoute = '/add_stock_in_route';
  static const stockInItemAddRoute = '/stock_in_item_add_route';
  static const stockInSummaryRoute = '/stock_in_summary_route';

  //end region

  //stock out region
  static const stockOutRoute = '/stock_out_route';
  static const addStockOutRoute = '/add_stock_out_route';
  static const stockOutItemAddRoute = '/stock_out_item_add_route';
  static const stockOutSummaryRoute = '/stock_out_summary_route';

  //end region

  //wastage region
  static const wastageRoute = '/wastage_route';
  static const addWastageRoute = '/add_wastage_route';
  static const wastageItemAddRoute = '/wastage_item_add_route';
  static const wastageSummaryRoute = '/wastage_summary_route';

  //end region

  //stock settlements region
  static const stockSettlementsRoute = '/stock_settlements_route';
  static const addStockSettlementsRoute = '/add_stock_settlements_route';
  static const stockSettlementsItemAddRoute =
      '/stock_settlements_item_add_route';
  static const stockSettlementsSummaryRoute =
      '/stock_settlements_summary_route';

  //end region

  //contra region
  static const jvRoute = '/jv_route';
  static const addJVRoute = '/add_jv_route';

  //end region

  //account ledger region
  static const accountLedgerRoute = '/account_ledger_route';

  //end region

  //stock report region
  static const stockReportRoute = '/stock_report_route';

  //end region

  //stock report region
  static const webGeneralSalesRoute = '/web_general_sales_route';

  //end region
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.initialRoute, page: () => SplashView()),
    GetPage(
      name: AppRoutes.loginRoute,
      binding: LoginBinding(),
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.dashBoardRoute,
      binding: DashboardBinding(),
      page: () => const DashboardView(),
    ),
    GetPage(
      name: AppRoutes.drawerRoute,
      //binding: AppDrawerBinding(),
      page: () => AppDrawerView(),
    ),
    GetPage(
      name: AppRoutes.salesRoute,
      binding: SalesBinding(),
      page: () => const SalesView(),
    ),

    //TODO : Web
    GetPage(
      name: AppRoutes.webGeneralSalesRoute,
      binding: WebGeneralSalesBinding(),
      page: () => const WebGeneralSalesView(),
    ),
  ];
}
