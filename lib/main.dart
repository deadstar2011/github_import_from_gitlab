import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:optima_delivery_mobile/common/helpers/api.dart';
import 'package:optima_delivery_mobile/common/models/PushNotificationModel.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/courier/models/CoordinateModel.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/courier/pages/ProfilePage.dart';
import 'package:optima_delivery_mobile/courier/pages/SignPage.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:optima_delivery_mobile/delivery/models/RouteModel.dart';
import 'package:optima_delivery_mobile/delivery/pages/DeliveryListPage.dart';
import 'package:optima_delivery_mobile/delivery/pages/DeliveryMapPage.dart';
import 'package:optima_delivery_mobile/delivery/pages/DeliveryPage.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/refuse_reason/models/RefuseReasonModel.dart';
import 'package:provider/provider.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('config');
  await api.setInitialBackUrl();
  await api.setInitialToken();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    S.load(Locale('ru'));
    return MultiProvider(
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        initialRoute: '/',
        theme: ThemeData(
          scaffoldBackgroundColor: StyleColors.white,
          buttonTheme: ButtonThemeData(
            buttonColor: StyleColors.primary7,
            textTheme: ButtonTextTheme.primary,
          ),
          primaryColor: StyleColors.white,
          accentColor: StyleColors.primary6,
          unselectedWidgetColor: StyleColors.graphite1,
          fontFamily: 'Roboto',
        ),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, _) => locale ?? Locale('ru', 'RU'),
        supportedLocales: S.delegate.supportedLocales,
        routes: {
          '/': (context) => SignPage(),
          '/profile': (context) => ProfilePage(),
          '/delivery': (context) =>
              DeliveryPage(ModalRoute.of(context).settings.arguments as int),
          '/map': (context) => DeliveryMapPage(
              ModalRoute.of(context).settings.arguments as AddressCoordinates),
          '/delivery-list': (context) => DeliveryListPage(),
        },
      ),
      providers: [
        ChangeNotifierProvider<DeliveryModel>(
          create: (context) => DeliveryModel(),
        ),
        ChangeNotifierProvider<RefuseReasonModel>(
          create: (context) => RefuseReasonModel(),
        ),
        ChangeNotifierProvider<CourierModel>(
          create: (context) => CourierModel(),
        ),
        ProxyProvider2<CourierModel, DeliveryModel, PushNotificationsModel>(
          update: (context, courierModel, deliveryModel, _) =>
              PushNotificationsModel(courierModel, deliveryModel),
        ),
        ProxyProvider<CourierModel, CoordinateModel>(
          update: (context, courierModel, _) =>
              CoordinateModel(courierModel.item),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<DeliveryModel, RouteModel>(
          create: (context) => RouteModel(null),
          update: (context, deliveryModel, routeModel) =>
              routeModel..updateItem(deliveryModel.currentItem),
        ),
        ValueListenableProvider.value(
          value: CoordinateModel.locationPermissionModel,
        ),
      ],
    );
  }
}
