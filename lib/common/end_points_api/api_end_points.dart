class ApiEndPoint {
  ApiEndPoint._();

  static String baseUrl = "https://hunger-station-clone.vercel.app/";
  static String generateOtp = '${baseUrl}customers/generate-otp';
  static String verifyOtp = '${baseUrl}customers/verify-otp';
  static String ads = '${baseUrl}ads';
  static String categories = '${baseUrl}categories';
  static String providersHome = 'providers/home';
  static String providersCustomers = 'providers/customers';
  static String couponsValidate = 'coupons/validate';
  static String orders = 'orders/customer';
  static String wallet = '${baseUrl}wallet';
  static String coupons = '${baseUrl}coupons';
  static String redeemPoints = 'redeem-points';
  static String providers = '${baseUrl}providers';
  static String myOrders = 'orders/customer';
  static String getAdsByCategory = 'ads/category';
  static String getNewCustomer = '${baseUrl}customers/auth/me';
}
