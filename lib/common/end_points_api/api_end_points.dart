class ApiEndPoint {
  ApiEndPoint._();
  static Uri uri(
          {required String path, Map<String, dynamic>? queryParameters}) =>
      Uri(
        scheme: "https",
        host: "hunger-station-clone.vercel.app",
        // port: _apiServer.port,
        path: path.replaceAll("https://hunger-station-clone.vercel.app", ""),
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
  static String coupons = '${baseUrl}coupons/saved';
  static String redeemPoints = 'redeem-points';
  static String providers = '${baseUrl}providers';
  static String myOrders = '${baseUrl}orders/customer';
  static String getAdsByCategory = '${baseUrl}ads/category';
  static String getNewCustomer = '${baseUrl}customers/auth/me';
  static String uploadFile = '${baseUrl}upload-file';
  static String saveCouponCustomer = '${baseUrl}coupons/saved';
}
