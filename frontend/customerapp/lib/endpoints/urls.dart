import 'package:customerapp/app_config.dart';

Future<String> makeUrl(EndpointDefinitions endpoint) async {
  final config = await AppConfig.getConfig();
  return '${config.apiUrl}${endpoint.value}';
}

class EndpointDefinitions {
  final String value;
  const EndpointDefinitions._internal(this.value);
  static const ORDERS = const EndpointDefinitions._internal('/orders');
  static const LOGIN = const EndpointDefinitions._internal('/users/login');
  static const REGISTER =
      const EndpointDefinitions._internal('/users/register');
  static const RESTAURANTS =
      const EndpointDefinitions._internal('/restaurants');
}
