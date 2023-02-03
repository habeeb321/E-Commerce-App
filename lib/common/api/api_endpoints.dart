class ApiEndPoints {
  // Auth end points
  static String signUp = 'api/v1/auth/signup';
  static String logIn = 'api/v1/auth/login';
  static String verifyOtp = 'api/v1/auth/otp';
  static String google = 'api/v1/auth/google';
  static String forgotPassword = 'api/v1/auth/password';
  static String refreshToken = 'api/v1/auth/refresh';

  // Home page end points
  static String category = 'api/v1/category';
  static String product = 'api/v1/products';
  static String carousal = 'api/v1/carousal';

  // Product page end points
  static String wishlist = 'api/v1/wishlist';
  static String cart = 'api/v1/cart';

  // Address
  static String address = 'api/v1/address';

  // order
  static String orders = 'api/v1/orders';

  // profile
  static const user = 'api/v1/users?email=';
}
