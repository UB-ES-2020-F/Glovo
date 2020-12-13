import 'package:customerapp/app_config.dart';

class EndpointDefinitions {
  static Future<String> makeOrdersURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/orders';
  }

  static Future<String> makeLoginURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/login';
  }

  static Future<String> makeRegisterURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/register';
  }

  static Future<String> makeRestaurantsURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/restaurants';
  }

  static Future<String> makeRestaurantsProductsURL(int restaurantId) async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' +
        '/restaurants/' +
        restaurantId.toString() +
        '/products';
  }

  static Future<String> makeLogoutURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/logout';
  }

  static Future<String> changeUserAndEmailURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/update';
  }

  static Future<String> changePasswordURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/update-password';
  }
  
  static Future<String> makeSendEmailForgotPasswordURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/password-email';
  }

  static Future<String> makeSetRecoveryPasswordURL() async {
    final config = await AppConfig.getConfig();
    return '${config.apiUrl}' + '/users/reset-password';
  }
}
