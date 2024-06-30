class ApiConstants {
  static const String apiBaseUrl = "https://roaiaofficial.runasp.net/api";

  static const String login = "$apiBaseUrl/Auth/login";
  static const String register = "$apiBaseUrl/Auth/register";
  static const String sendOtp = "$apiBaseUrl/Auth/SendOTPCode";
  static const String otbVerification = "$apiBaseUrl/Auth/otbVerification";
  static const String resetPass = "$apiBaseUrl/Auth/resetPassword";
  static const String changePassword = "$apiBaseUrl/Auth/changePassword";
  static const String userInfo = "$apiBaseUrl/Account/userinfo";
  static const String blindInfo = "$apiBaseUrl/Account/blindinfo";
  static const String refreshToken = "$apiBaseUrl/Auth/refreshToken";
  static const String editProfile = "$apiBaseUrl/Auth/modifyUser";
  static const String editBlind = "$apiBaseUrl/Account/ModifyBlindInfo";
  static const String AddContact = "$apiBaseUrl/Account/AddContact";
  static const String getContacts = "$apiBaseUrl/Account/getAllContacts";
  static const String getNotifications = "$apiBaseUrl/Account/GetNotificationsByGlassesId";
  static const String DeleteNotifications = "$apiBaseUrl/Account/DeleteNotifications";
  static const String DeleteAccount = "$apiBaseUrl/Account/DeleteAccount";
}
