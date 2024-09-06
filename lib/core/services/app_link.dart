class AppLink {
  static const String ipConfig = '127.0.0.1';
  static const String server = 'http://$ipConfig:8000/api';

  //! prefix path image
  static const String prefixPathImage = 'http://$ipConfig:8000/';

  //! Auth
  static const String login = '$server/admin/login';

  //! category
  static const String category = '$server/get-all-categories';

  //! ====================  Get Categories ====================
  static const String getAllCategories = "$server/get-all-categories";
  static const String updateCategories = "$server/admin/update-category";
  static const String createCategories = "$server/admin/create-category";
  static const String deleteCategories = "$server/admin/delete-category";

  //! ====================  Get Drug <=> For One Category ====================
  static const String drugCategory = "$server/get-category-medications";

  //! ====================   Drug  ====================
  static const String getOneMedication = "$server/get-one-medication";
  static const String underOneMonth = "$server/get-under-one-month-sale";
  static const String underThreeMonth = "$server/get-under-three-months-sale";
  static const String mostPopular = "$server/most-popular-medications";
  static const String dailySale = "$server/get-daily-sale-medications";
  static const String getAllMedication = "$server/get-all-medications";
  static const String updateMedication = "$server/admin/update-medication";
  static const String deleteMedication = "$server/admin/delete-medication";
  static const String createMedication = "$server/admin/create-medication";

  //! Order
  static const String getAllOrder = "$server/admin/get-all-orders";
  static const String payOrder = "$server/admin/pay-order";
  static const String cancelOrder = "$server/cancel-order";
  static const String deliverOrder = "$server/admin/deliver-order";
  static const String shipOrder = "$server/admin/ship-order";

  //! token
  static const String upToken = "$server/admin/set-notification-token";
}
