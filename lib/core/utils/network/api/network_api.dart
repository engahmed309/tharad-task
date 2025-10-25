class Api {
  //base Url
  static const String mainAppUrl = "https://gahez.runasp.net/";
  //Base image url
  static const String baseImageUrl = "https://gahez.runasp.net";
  //end points
  static const String baseUrl = "$mainAppUrl/Api/V1/";
  static const String doServerLoginApiCall = "Authentication/SignIn";
  static const String registerUserApiCall = "Authentication/Register";
  static const String registerProviderApiCall =
      "Authentication/Register-Provider";
  static const String getCategoriesApiCall = "api/Category/Api/V1/categories";
  static const String getCurrentUserApiCall = "Profile/Current";
  static const String getNearbyProvidersApiCall = "api/providers/nearby";
  static const String createServiceApiCall = "Api/V1/Service";
  static const String getConversationsApiCall = "api/Message/conversations";

  static const String getChatMessagesApiCall = "api/Message/messages";
  static const String sendMessageApiCall = "/api/Message/send";
  static const String createConversationApiCall =
      "/api/Message/create-conversation";

  static const String getUserOrdersApiCall = "Api/V1/Service/user";
}
