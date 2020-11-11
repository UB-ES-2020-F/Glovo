import 'package:customerapp/app_config.dart';

Future<String> makeUrl(EndpointDefinitions endpoint) async {
  final config = await AppConfig.getConfig();
  return '${config.apiUrl}$endpoint';
}

class EndpointDefinitions {
  final String value;
  const EndpointDefinitions._internal(this.value);
  static const ORDERS = const EndpointDefinitions._internal('/orders');
}
