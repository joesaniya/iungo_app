import 'package:iungo_application/Business-Logic/Dashboard_provider.dart';
import 'package:iungo_application/Business-Logic/Profile_provider.dart';
import 'package:iungo_application/Business-Logic/activity_tab_provider.dart';
import 'package:iungo_application/Business-Logic/auth_provider.dart';
import 'package:iungo_application/Business-Logic/client_provider.dart';
import 'package:iungo_application/Business-Logic/date_rande_picker_provider.dart';
import 'package:iungo_application/Business-Logic/route_tab_provider.dart';
import 'package:iungo_application/Business-Logic/splash-provider.dart';
import 'package:iungo_application/Business-Logic/waste_management_provider.dart';
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
    ChangeNotifierProvider(create: (_) => ClientProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => ActivityTabProvider()),
    ChangeNotifierProvider(create: (_) => RouteTabProvider()),

    ChangeNotifierProvider(create: (_) => WasteManagementProvider()),
    ChangeNotifierProvider(create: (_) => DateRangePickerProvider()),
  ];
}
