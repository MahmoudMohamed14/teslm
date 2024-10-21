class ApiEndPoint {
  ApiEndPoint._();
  static Uri uri(
          {required String path, Map<String, dynamic>? queryParameters}) =>
      Uri(
        scheme: "http",
        host: "147.79.114.89",
        port: 5050,
        path: path.startsWith('/') ? path : '/$path',
        queryParameters: queryParameters,
      );
  static String baseUrl = "http://147.79.114.89:5050/";
  static String generateOtp = '${baseUrl}customers/generate-otp';
  static String verifyOtp = '${baseUrl}customers/verify-otp';
  static String ads = '${baseUrl}ads';
  static String categories = '${baseUrl}categories';
  static String providersHome = '${baseUrl}providers/home';
  static String providersCustomers = '${baseUrl}providers/customers';
  static String couponsValidate = '${baseUrl}coupons/validate';
  static String orders = '${baseUrl}orders/customer';
  static String wallet = '${baseUrl}wallet';
  static String coupons = 'coupons/saved';
  static String redeemPoints = 'redeem-points';
  static String providers = '${baseUrl}providers';
  static String myOrders = '${baseUrl}orders/customer';
  static String getAdsByCategory = '${baseUrl}ads/category';
  static String getNewCustomer = '${baseUrl}customers/auth/me';
  static String uploadFile = '${baseUrl}upload-file';
  static String saveCouponCustomer = '${baseUrl}coupons/saved';
  static String createPayments = '${baseUrl}payments';
  static String moyasarPaymentKey = 'sk_test_4hPQUZG3KYCdoRCRkQvoSYAtDyDdEYcRRk27a5mo';
  static String moyasarPaymentUrl = 'https://api.moyasar.com/v1/payments';
}
