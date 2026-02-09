import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/Business-Logic/splash-provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderHelperClass {
  static ProviderHelperClass? _instance;

  static ProviderHelperClass get instance {
    _instance ??= ProviderHelperClass();
    return _instance!;
  }

  List<SingleChildWidget> providerLists = [
    ChangeNotifierProvider(create: (context) => SplashProvider(context)),

    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => DashboardProvider()),
  ];
}
