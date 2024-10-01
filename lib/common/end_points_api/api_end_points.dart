class ApiEndPoint {
  ApiEndPoint._();

  static String baseUrl = "https://hunger-station-clone.vercel.app/";
  static String generateOtp = '${baseUrl}customers/generate-otp';
  static String verifyOtp = '${baseUrl}customers/verify-otp';
  static String ads = '${baseUrl}ads';
  static String categories = '${baseUrl}categories';
  static String providersHome = '${baseUrl}providers/home';
  static String providersCustomers = '${baseUrl}providers/customers';
  static String couponsValidate = 'coupons/validate';
  static String orders = 'orders/customer';
  static String wallet = 'wallet';
  static String coupons = 'coupons';
  static String redeemPoints = 'redeem-points';
  static String providers = 'providers';
  static String myOrders = 'orders/customer';
  static String getAdsByCategory = '${baseUrl}ads/category';
  static String getNewCustomer = '${baseUrl}customers/auth/me';
}
