class ApiEndPoint {
  ApiEndPoint._();

  static String baseUrl = "https://hunger-station-clone.vercel.app/";
  static String generateOtp = '${baseUrl}customers/generate-otp';
  static String verifyOtp = '${baseUrl}customers/verify-otp';
  static String ads = 'ads';
  static String categories = 'categories';
  static String providersHome = 'providers/home';
  static String providersCustomers = 'providers/customers';
  static String couponsValidate = 'coupons/validate';
  static String orders = 'orders';
  static String wallet = 'wallet';
  static String coupons = 'coupons';
  static String redeemPoints = 'redeem-points';
  static String providers = 'providers';
  static String myOrders = 'orders/customer';
  static String getAdsByCategory = 'ads/category';

}
