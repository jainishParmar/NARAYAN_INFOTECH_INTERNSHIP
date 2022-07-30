class Appconstants {
  static const String BASE_URL = "http://10.0.2.2:8000";
  static const String UPLOAD_URL = "/uploads/";


  static const String REGISTRATION_URI = "/api/auth/register";
  static const String LOGIN_URI = "/api/auth/login";
  static const String USER_INFO_URI= "/api/auth/user-profile";
  static const String LOGOUT = "/api/auth/logout";
  static const String FORGETPASSWORD = "/api/auth/forget-password";
  static const String RESETPASSWORD = "/api/auth/reset-password";
  static const String COMPAREOTP = "/api/auth/compare-otp";




  static const String GET_ITEMS = "/api/inventory/popular_items";
  static const String RECOMMENDED_PRODUCT_URI = "/api/inventory/recommanded_items";
  static const String ALL_PRODUCT_URI = "/api/inventory/all";


  static const String CART_LIST = "cart-list";
  static const String DELETE_CART_LIST = "/api/inventory/cart_delete";
 static const  String DELETE_ZERO_QAUNTITY_CART = "/api/inventory/zero_quantity_cart_delete";


  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String DB_STORE_CART = "/api/inventory/cart";
  static const String DB_STORE_ORDER = "/api/inventory/order";
  static const String GET_CART_TOTAL_ITEMS = "/api/inventory/cart_total_items";
  static const String GET_CART_TOTAL_AMOUNT = "/api/inventory/cart_total_amount";
  static const String GET_CURRENT_QUANTITY_IN_CART_OF_PARTICULAR_ITEM = "/api/inventory/cart_item_curren_quantity";


  static const String TOKEN = "";
  static const String EMAIL = "";
  static const String PASSWORD = "";
}
