import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import './utils/auth.dart';
import './utils/api_helper.dart';
import './constants/constant.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Auth()),
  Provider.value(value: Map<String, dynamic>())
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<Auth, CHttp>(
    update: (context, auth, cHttp) => CHttp(baseURL: baseUrl, auth: auth),
  ),
];
List<SingleChildWidget> uiConsumableProviders = [];

